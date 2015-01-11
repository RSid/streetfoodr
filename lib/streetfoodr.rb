require 'rest-client'

class FoodTruck
  API_ROOT_URL = 'http://data.streetfoodapp.com/1.1/'

  def self.city_schedule(city)
    response = RestClient.get(API_ROOT_URL + "schedule/" + city)
    JSON.parse(response)
  end

  def locations
  end

  def history
  end
end
