# frozen_string_literal: true

class GeocodingService
  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com/') do |faraday|
      faraday.params['key'] = ENV['geo_key']
    end
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_coordinates(location)
    response = connection.get("geocoding/v1/address?location=#{location}")
    get_json(response)
  end

  def self.get_route(origin, destination)
    response = connection.get("directions/v2/route?from=#{origin}&to=#{destination}")
    get_json(response)
  end
end
