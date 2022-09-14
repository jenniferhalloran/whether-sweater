class DailyWeather
  attr_reader :date, 
              :sunrise, 
              :sunset, 
              :max_temp, 
              :min_temp, 
              :conditions, 
              :icon

  def initialize(daily_data)
    @date = Time.at(daily_data[:dt])
    @sunrise = Time.at(daily_data[:sunrise])
    @sunset = Time.at(daily_data[:sunset])
    @max_temp = daily_data[:temp][:max].to_f
    @min_temp = daily_data[:temp][:min].to_f
    @conditions = daily_data[:weather][0][:description]
    @icon = daily_data[:weather][0][:icon]
  end
end