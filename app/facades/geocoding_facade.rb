# frozen_string_literal: true

class GeocodingFacade
  def self.get_coordinates(location)
    geodata = GeocodingService.get_coordinates(location)
    Coordinates.new(geodata[:results][0][:locations][0])
  end

  def self.get_route(origin, destination)
    route_data = GeocodingService.get_route(origin, destination)[:route]
    if route_data[:routeError][:errorCode] == 2
      "impossible route"
    else
      Route.new(origin, destination, route_data)
    end
  end

end
