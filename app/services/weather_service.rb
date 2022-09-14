# frozen_string_literal: true

class WeatherService
  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org/') do |faraday|
      faraday.params['appid'] = ENV['weather_key']
    end
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_weather(latitude, longitude)
    response = connection.get("data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&units=imperial&exclude=minutely")
    get_json(response)
  end
end
