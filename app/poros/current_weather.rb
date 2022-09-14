# frozen_string_literal: true

class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(current_data)
    @datetime = Time.at(current_data[:dt])
    @sunrise = Time.at(current_data[:sunrise])
    @sunset = Time.at(current_data[:sunset])
    @temperature = current_data[:temp].to_f
    @feels_like = current_data[:feels_like].to_f
    @humidity = current_data[:humidity]
    @uvi = current_data[:uvi]
    @visibility = current_data[:visibility]
    @conditions = current_data[:weather][0][:description]
    @icon = current_data[:weather][0][:icon]
  end
end
