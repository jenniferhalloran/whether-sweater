# frozen_string_literal: true

class WeatherFacade
  def self.get_weather(latitude, longitude)
    weather_data = WeatherService.get_weather(latitude, longitude)

    current = CurrentWeather.new(weather_data[:current])

    daily = weather_data[:daily][0..4].map do |daily_weather|
      DailyWeather.new(daily_weather)
    end

    hourly = weather_data[:hourly].map do |hourly_weather|
      HourlyWeather.new(hourly_weather)
    end
    { current_weather: current, daily_weather: daily, hourly_weather: hourly }
  end

  def self.get_weather_at_eta(latitude, longitude, travel_time)
    weather = WeatherService.get_weather(latitude, longitude)
    if travel_time < 48
      {temperature: weather[:hourly][travel_time][:temp], conditions: weather[:hourly][travel_time][:weather][0][:description]}
    else
      days = travel_time / 24
      {temperature: weather[:daily][days][:temp][:day], conditions: weather[:daily][days][:weather][0][:description]}
    end
  end
end
