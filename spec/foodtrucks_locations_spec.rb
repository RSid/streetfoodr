require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

describe "#foodtruck locations" do
  it 'gets all the locations a given food truck frequents' do
    VCR.use_cassette("boston_bon-me_truck_locations_response") do
      foodtruck = FoodTruck.new("bon-me", "boston")

      locations = foodtruck.locations

      expect(locations.length).to be > 0
    end
  end

  it 'throws a useful error when the identifier is wrong' do
    VCR.use_cassette("fake_foodtruck_blarge_locations_response") do
      foodtruck = FoodTruck.new("blargle", "boston")

      expect{ foodtruck.locations }
      .to raise_error(ArgumentError, "This food truck identifier does not exist")
    end
  end
end
