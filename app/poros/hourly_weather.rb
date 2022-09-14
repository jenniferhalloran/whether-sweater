# frozen_string_literal: true

class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = formatted_time(data[:dt])
    @temperature = data[:temp].to_f
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def formatted_time(time)
    Time.at(time).to_s.split.second
  end
end
