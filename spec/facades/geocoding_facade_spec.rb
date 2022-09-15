# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodingFacade do
  describe '#get_coordinates(location)' do
    it 'returns a coordinate object' do
      coordinates = GeocodingFacade.get_coordinates('denver,co')

      expect(coordinates).to be_a(Coordinates)

      expect(coordinates.latitude).to be_a(Float)
      expect(coordinates.longitude).to be_a(Float)
    end
  end
  describe '#get_route(origin, destination)' do
    it 'returns a route object' do
      route = GeocodingFacade.get_route('Denver, CO', 'Pueblo, CO')

      expect(route).to be_a(Route)
    end
  end
end
