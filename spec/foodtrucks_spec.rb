require 'spec_helper.rb'

describe "#initialize" do
  it 'initializes a new instance of a food truck' do
    foodtruck = FoodTruck.new("momos", "boston")
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
    foodtruck = FoodTruck.new("bon-me", "boston")

    locations = foodtruck.locations

    expect(locations.length).to be > 0
  end

  it 'throws a useful error when the identifier is wrong' do
    foodtruck = FoodTruck.new("blargle", "boston")

    expect{ foodtruck.locations }
    .to raise_error(ArgumentError, "This food truck identifier does not exist")
  end
end

describe "#foodtruck history" do
  it "gets the history of a food truck's schedule for a given month and year" do
    foodtruck = FoodTruck.new("bon-me", "boston")

    november_2013_history = foodtruck.history("2013", "11")

    expect(november_2013_history.length).to be > 0
  end
end
