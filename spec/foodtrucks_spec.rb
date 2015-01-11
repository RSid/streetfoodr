require 'spec_helper.rb'

describe "#foodtrucks city schedule" do
  it 'gets all food truck data for a given city' do
    boston_foodtrucks_data = FoodTruck.city_schedule("boston")
    expect(boston_foodtrucks_data.length).to be > 0

    toronto_foodtrucks_data = FoodTruck.city_schedule("toronto")
    expect(boston_foodtrucks_data.length).to be > 0
  end
end
