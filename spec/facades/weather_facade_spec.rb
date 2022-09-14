# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherFacade do
  describe '#get_weather(latitude,longitude)', :vcr do
    it 'returns the daily, current, and hourly weather for a location as objects' do
      weather = WeatherFacade.get_weather(39.738453, -104.984853)
      expect(weather[:current_weather]).to be_a(CurrentWeather)
      expect(weather[:daily_weather]).to be_all(DailyWeather)
      expect(weather[:hourly_weather]).to be_all(HourlyWeather)
      expect(weather[:hourly_weather].count).to eq(48)
    end
  end
end
