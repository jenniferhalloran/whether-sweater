# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodingService do
  describe '#get_coordinates(location)' do
    it 'returns latitude, longitude, and other data based on given location' do
      geodata = GeocodingService.get_coordinates('denver,co')

      expect(geodata).to be_a Hash
      expect(geodata[:results]).to be_an Array
      expect(geodata[:results][0][:providedLocation][:location]).to eq('denver,co')
      expect(geodata[:results][0][:locations][0][:adminArea5]).to eq('Denver')
      expect(geodata[:results][0][:locations][0][:adminArea3]).to eq('CO')
      expect(geodata[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(geodata[:results][0][:locations][0][:latLng]).to have_key(:lng)
    end
  end

  describe '#get_route(origin, desination)' do
    it 'returns a routes starting geolocation, ending geolocation, and time to get there' do
      route_data = GeocodingService.get_route('Denver,CO', 'Pueblo,CO')

      expect(route_data).to be_a Hash
      expect(route_data[:route][:boundingBox][:lr][:lng]).to be_a Float
      expect(route_data[:route][:boundingBox][:lr][:lat]).to be_a Float
      expect(route_data[:route][:boundingBox][:ul][:lng]).to be_a Float
      expect(route_data[:route][:boundingBox][:ul][:lat]).to be_a Float
      expect(route_data[:route][:formattedTime]).to be_a String
    end
  end
end
