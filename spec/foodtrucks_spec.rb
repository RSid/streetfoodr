require 'spec_helper.rb'

describe "#initialize" do
  it 'initializes a new instance of a food truck' do
    foodtruck = FoodTruck.new("momos")
    expect(foodtruck).to be_a FoodTruck
  end
end

describe "#foodtrucks city schedule" do
  it 'gets all food truck data for a given city' do
    boston_foodtrucks_data = FoodTruck.city_schedule("boston")
    expect(boston_foodtrucks_data.length).to be > 0

    toronto_foodtrucks_data = FoodTruck.city_schedule("toronto")
    expect(boston_foodtrucks_data.length).to be > 0
  end

  it 'throws a useful error when the city does not have data' do
    expect{ FoodTruck.city_schedule("thimphu") }
      .to raise_error(RestClient::ResourceNotFound)
  end
end

describe "#foodtruck locations" do
  it 'gets all the locations a given food truck frequents' do
    foodtruck = FoodTruck.new("bon-me")

    locations = foodtruck.locations

    expect(locations.length).to be > 0
  end
end
