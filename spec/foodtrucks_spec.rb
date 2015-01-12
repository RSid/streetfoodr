require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

describe "#initialize" do
  it 'initializes a new instance of a food truck' do
    foodtruck = FoodTruck.new("momos", "boston")
    expect(foodtruck).to be_a FoodTruck
  end
end

describe "#foodtrucks city schedule" do
  it 'gets all food truck data for a given city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      boston_foodtrucks_data = FoodTruck.city_schedule("boston")

      expect(boston_foodtrucks_data.length).to be > 0
    end

    VCR.use_cassette("toronto_foodtrucks_response") do
      toronto_foodtrucks_data = FoodTruck.city_schedule("toronto")

      expect(toronto_foodtrucks_data.length).to be > 0
    end
  end

  it 'throws a useful error when the city does not have data' do
    VCR.use_cassette("imaginary_thimphu_foodtrucks_response") do
      expect{ FoodTruck.city_schedule("thimphu") }
        .to raise_error(RestClient::ResourceNotFound)
      end
  end
end

describe "#foodtrucks city identifiers" do
  it 'retrievers the names and api identifiers for all trucks in a city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      boston_foodtrucks_identifiers = FoodTruck.city_truck_identifiers("boston")

      expect(boston_foodtrucks_identifiers.length).to be > 0
      expect(boston_foodtrucks_identifiers[0]).to be_a Hash
      expect(boston_foodtrucks_identifiers[0].keys.include?(:identifier)).to eql(true)
      expect(boston_foodtrucks_identifiers[0].keys.include?(:name)).to eql(true)
    end
  end
end

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

describe "#foodtruck history" do
  it "gets the history of a food truck's schedule for a given month and year" do
    VCR.use_cassette("november2013_bon-me_foodtruck_history_response") do
      foodtruck = FoodTruck.new("bon-me", "boston")

      november_2013_history = foodtruck.history("2013", "11")

      expect(november_2013_history.length).to be > 0
    end
  end

  it 'throws a useful error when the information is unavailable' do
    VCR.use_cassette("no_history_for_november2000_bon-me_foodtruck_history_response") do
      foodtruck = FoodTruck.new("bon-me", "boston")

      expect{ foodtruck.history("2000", "11") }
      .to raise_error(ArgumentError,
      "Either this food truck identifier does not exist, or there is " +
      "no history for it available during the period you have chosen.")
    end
  end
end
