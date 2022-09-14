# frozen_string_literal: true

class ForecastSerializer
  def self.format_forecast(weather)
    {
      "data": {
        "id": nil,
        "type": 'forecast',
        "attributes": {
          "current_weather": {
            "datetime": weather[:current_weather].datetime,
            "sunrise": weather[:current_weather].sunrise,
            "sunset": weather[:current_weather].sunset,
            "temperature": weather[:current_weather].temperature,
            "feels_like": weather[:current_weather].feels_like,
            "humidity": weather[:current_weather].humidity,
            "uvi": weather[:current_weather].uvi,
            "visibility": weather[:current_weather].visibility,
            "conditions": weather[:current_weather].conditions,
            "icon": weather[:current_weather].icon
          },
          "daily_weather": weather[:daily_weather].map do |daily_weather|
            {
              "date": daily_weather.date,
              "sunrise": daily_weather.sunrise,
              "sunset": daily_weather.sunset,
              "max_temp": daily_weather.max_temp,
              "min_temp": daily_weather.min_temp,
              "conditions": daily_weather.conditions,
              "icon": daily_weather.icon
            }
          end,
          "hourly_weather": weather[:hourly_weather][0..7].map do |hourly_weather|
            {
              "time": hourly_weather.time,
              "temperature": hourly_weather.temperature,
              "conditions": hourly_weather.conditions,
              "icon": hourly_weather.icon
            }
          end
        }
      }
    }
  end
end
