require 'rest-client'

##
#This class represents food trucks

module Streetfoodr
  class FoodTruck
    API_ROOT_URL = 'http://data.streetfoodapp.com/1.1/'

    ##
    #Gets all the food trucks and their schedules for a given city
    def self.get_city_trucks(city)
      response = RestClient.get(API_ROOT_URL + "schedule/" + city)
      JSON.parse(response)
    end

    ##
    #Gets the api identifier information for all the food trucks in a
    #given city. The identifiers are necessary for getting information
    #about a specific food truck only.
    def self.get_city_trucks_identifiers(city)
      raw_data = self.get_city_trucks(city)

      identifier_name_pairs = Array.new

      raw_data['vendors'].map do |truck|
        truck_info = Hash[identifier: truck[0], name: truck[1]["name"]]

        identifier_name_pairs << truck_info
      end

      return identifier_name_pairs
    end

    ##
    #Finds the api identifier of a truck by name and city.
    def self.get_api_identifier_by_name(name, city)

      truck_info = self.get_city_trucks_identifiers(city)
      .find { |truck_info| truck_info[:name] == name}

      if truck_info == nil
        raise ArgumentError,  "A truck with that name in that city could not be found." +
        " Keep in mind that the name must be exact."
      end

      return truck_info
    end

    ##
    #Initializes a new instance of a specific food truck
    def initialize(foodtruck_identifier, city)
      @identifier = foodtruck_identifier
      @city = city
    end

    ##
    #Gets the locations and schedule of a given food truck
    def locations
      response = RestClient.get(API_ROOT_URL + "locations/" + @identifier)
      begin
        JSON.parse(response)
      rescue JSON::ParserError => ex
        raise ArgumentError, "This food truck identifier does not exist"
      end
    end

    ##
    #Gets the locations and schedule of a given food truck
    #during a specific month and year
    def history(year, month)
      response = RestClient.get(API_ROOT_URL + "history/" + @city + "/" +
      year + "/" + month + "/" + @identifier)
      begin
        JSON.parse(response)
      rescue JSON::ParserError => ex
        raise ArgumentError, "Either this food truck identifier does not exist," +
        " or there is no history for it available during the period you have chosen."
      end
    end
  end
end
