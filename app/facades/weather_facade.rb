class WeatherFacade 
  def self.get_weather(latitude, longitude)
    weather_data = WeatherService.get_weather(latitude, longitude)

    current = CurrentWeather.new(weather_data[:current])
    
    daily = weather_data[:daily][0..4].map do |daily_weather|
      DailyWeather.new(daily_weather)
    end
    
    hourly =  weather_data[:hourly].map do |hourly_weather|
      HourlyWeather.new(hourly_weather)
    end
    {current_weather: current, daily_weather: daily, hourly_weather: hourly}
  end
end