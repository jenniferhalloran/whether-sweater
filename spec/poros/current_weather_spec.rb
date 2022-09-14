require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    data = JSON.parse(File.read('./spec/fixtures/weather.json'), symbolize_names: true)[:current]

    current_weather = CurrentWeather.new(data)

    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to eq('2022-08-04 08:16:28.000000000 -0400')
    expect(current_weather.sunrise).to eq('2022-08-04 08:01:45.000000000 -0400')
    expect(current_weather.sunset).to eq('2022-08-04 22:10:15.000000000 -0400')
    expect(current_weather.temperature).to eq(66.78)
    expect(current_weather.feels_like).to eq(66.07)
    expect(current_weather.humidity).to eq(62)
    expect(current_weather.visibility).to eq(10_000)
    expect(current_weather.uvi).to eq(0)
    expect(current_weather.icon).to eq('01d')
  end
end