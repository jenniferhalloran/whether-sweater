module WeatherHelper 
  def self.eta_weather(route, weather)
    if route.hours_to_destination < 48
      {temperature: weather[:hourly_weather][route.hours_to_destination].temperature, conditions: weather[:hourly_weather][route.hours_to_destination].conditions}
    else
      days = route.hours_to_destination / 24
      {temperature: weather[:daily_weather][days].max_temp, conditions: weather[:daily_weather][days].conditions}
    end
  end
end