require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists and has attributes' do
    data = JSON.parse(File.read('./spec/fixtures/weather.json'), symbolize_names: true)[:hourly][0]

    hourly_weather = HourlyWeather.new(data)
    
    expect(hourly_weather).to be_a(HourlyWeather)
    expect(hourly_weather.time).to eq("08:00:00")
    expect(hourly_weather.temperature).to eq(66.78)
    expect(hourly_weather.conditions).to eq("clear sky")
    expect(hourly_weather.icon).to eq('01n')
  end
end