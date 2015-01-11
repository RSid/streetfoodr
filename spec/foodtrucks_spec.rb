require 'spec_helper.rb'

describe "#foodtrucks" do
  it 'gets all food truck data for a given city' do
    boston_foodtrucks_data = FoodTruck.city_schedule("boston")
    expect(boston_foodtrucks_data.length).to be > 0
  end
end
