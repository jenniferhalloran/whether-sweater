# frozen_string_literal: true

class GeocodingFacade
  def self.get_coordinates(location)
    geodata = GeocodingService.get_coordinates(location)
    Coordinates.new(geodata[:results][0][:locations][0])
  end
end
