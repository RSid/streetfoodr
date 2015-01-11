require 'rest-client'

class FoodTruck
  API_ROOT_URL = 'http://data.streetfoodapp.com/1.1/'

  def self.city_schedule(city)
    response = RestClient.get(API_ROOT_URL + "schedule/" + city)
    JSON.parse(response)
  end

  def initialize(foodtruck_identifier)
    @identifier = foodtruck_identifier
  end

  def locations
    response = RestClient.get(API_ROOT_URL + "locations/" + @identifier)
    begin
      JSON.parse(response)
    rescue JSON::ParserError => ex
      raise ArgumentError, "This food truck identifier does not exist"
    end
  end

  def history
  end
end
