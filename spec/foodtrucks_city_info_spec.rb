require 'spec_helper.rb'
require 'vcr'
require 'support/vcr_setup.rb'

describe "#foodtrucks city schedule" do
  it 'gets all food truck data for a given city' do
    VCR.use_cassette("boston_foodtrucks_response") do
      boston_foodtrucks_data = Streetfoodr::FoodTruck.get_city_trucks("boston")

      expect(boston_foodtrucks_data.length).to be > 0
    end

    VCR.use_cassette("toronto_foodtrucks_response") do
      toronto_foodtrucks_data = Streetfoodr::FoodTruck.get_city_trucks("toronto")

      expect(toronto_foodtrucks_data.length).to be > 0
    end
  end

  it 'throws a useful error when the city does not have data' do
    VCR.use_cassette("imaginary_thimphu_foodtrucks_response") do
      expect{ Streetfoodr::FoodTruck.get_city_trucks("thimphu") }
        .to raise_error(RestClient::ResourceNotFound)
      end
  end
end
