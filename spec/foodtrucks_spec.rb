require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

describe "#initialize" do
  it 'initializes a new instance of a food truck' do
    foodtruck = FoodTruck.new("momos", "boston")
    expect(foodtruck).to be_a FoodTruck
  end
end

describe "#foodtrucks city identifiers" do
  it 'retrievers the names and api identifiers for all trucks in a city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      boston_foodtrucks_identifiers = FoodTruck.get_citys_trucks_identifiers("boston")

      expect(boston_foodtrucks_identifiers.length).to be > 0
      expect(boston_foodtrucks_identifiers[0]).to be_a Hash
      expect(boston_foodtrucks_identifiers[0].keys.include?(:identifier)).to eql(true)
      expect(boston_foodtrucks_identifiers[0].keys.include?(:name)).to eql(true)
    end
  end
end
