# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists and has attributes' do
    data = JSON.parse(File.read('./spec/fixtures/weather.json'), symbolize_names: true)[:daily][0]

    daily_weather = DailyWeather.new(data)

    expect(daily_weather).to be_a(DailyWeather)
    expect(daily_weather.date).to eq('2022-08-04 15:00:00 -0400')
    expect(daily_weather.sunrise).to eq('2022-08-04 08:01:45 -0400')
    expect(daily_weather.sunset).to eq('2022-08-04 22:10:15 -0400')
    expect(daily_weather.min_temp).to eq(66.78)
    expect(daily_weather.max_temp).to eq(95.54)
    expect(daily_weather.conditions).to eq('clear sky')
    expect(daily_weather.icon).to eq('01d')
  end
end
