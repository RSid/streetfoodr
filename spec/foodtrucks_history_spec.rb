require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

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
