require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

describe "#initialize" do
  it 'initializes a new instance of a food truck' do
    foodtruck = Streetfoodr::FoodTruck.new("momos", "boston")
    expect(foodtruck).to be_a Streetfoodr::FoodTruck
  end
end

describe "#foodtrucks city identifiers" do
  it 'retrieves the names and api identifiers for all trucks in a city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      boston_foodtrucks_identifiers = Streetfoodr::FoodTruck.get_city_trucks_identifiers("boston")

      expect(boston_foodtrucks_identifiers.length).to be > 0
      expect(boston_foodtrucks_identifiers[0]).to be_a Hash
      expect(boston_foodtrucks_identifiers[0].keys.include?(:identifier)).to eql(true)
      expect(boston_foodtrucks_identifiers[0].keys.include?(:name)).to eql(true)
    end
  end
end

describe "#get_trucks_api_identifier_by_name" do
  it 'retrieves the api identifier of a food truck by its name' do
    VCR.use_cassette("boston_foodtrucks_response") do
      foodtruck_name = "Stoked Wood Fired Pizza Co."

      identifier = Streetfoodr::FoodTruck.get_api_identifier_by_name(foodtruck_name,
      "boston")

      expect(identifier[:identifier]).to eql("stoked")
      expect(identifier[:name]).to eql(foodtruck_name)
    end
  end

  it 'throws a useful error if there is no foodtruck by that name in that city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      foodtruck_name = "Not a real food truck"

      expect{ Streetfoodr::FoodTruck.get_api_identifier_by_name(foodtruck_name,
        "boston") }
        .to raise_error(ArgumentError, "A truck with that name in that city" +
        " could not be found. Keep in mind that the name must be exact.")
    end
  end
end
