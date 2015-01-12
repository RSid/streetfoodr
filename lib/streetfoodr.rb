require 'rest-client'
require 'pry'

class FoodTruck
  API_ROOT_URL = 'http://data.streetfoodapp.com/1.1/'

  def self.city_schedule(city)
    response = RestClient.get(API_ROOT_URL + "schedule/" + city)
    JSON.parse(response)
  end

  def self.city_truck_identifiers(city)
    raw_data = self.city_schedule(city)

    identifier_name_pairs = Array.new

    raw_data['vendors'].map do |truck|
      truck_info = Hash[identifier: truck[0], name: truck[1]["name"]]

      identifier_name_pairs << truck_info
    end

    return identifier_name_pairs
  end

  def initialize(foodtruck_identifier, city)
    @identifier = foodtruck_identifier
    @city = city
  end

  def locations
    response = RestClient.get(API_ROOT_URL + "locations/" + @identifier)
    begin
      JSON.parse(response)
    rescue JSON::ParserError => ex
      raise ArgumentError, "This food truck identifier does not exist"
    end
  end

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
