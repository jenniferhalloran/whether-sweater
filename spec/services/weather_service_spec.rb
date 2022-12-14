# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe '#get_weather(latitude, longitude)' do
    it 'returns the daily, weekly, and hourly weather for the given location' do
      weather_data = WeatherService.get_weather(39.738453, -104.984853)

      expect(weather_data).to be_a Hash

      expect(weather_data[:current]).to be_a Hash
      expect(weather_data[:current][:dt]).to be_an Integer
      expect(weather_data[:current][:sunrise]).to be_an Integer
      expect(weather_data[:current][:sunset]).to be_an Integer
      expect(weather_data[:current][:temp]).to be_a Numeric
      expect(weather_data[:current][:feels_like]).to be_a Numeric
      expect(weather_data[:current][:humidity]).to be_an Integer
      expect(weather_data[:current][:visibility]).to be_an Integer
      expect(weather_data[:current]).to have_key(:uvi)
      expect(weather_data[:current][:weather]).to be_an Array
      expect(weather_data[:current][:weather][0]).to be_a Hash
      expect(weather_data[:current][:weather][0][:description]).to be_a String
      expect(weather_data[:current][:weather][0][:icon]).to be_a String

      expect(weather_data[:daily]).to be_an Array
      expect(weather_data[:daily][0][:dt]).to be_an Integer
      expect(weather_data[:daily][0][:sunrise]).to be_an Integer
      expect(weather_data[:daily][0][:sunset]).to be_an Integer
      expect(weather_data[:daily][0][:temp]).to be_a Hash
      expect(weather_data[:daily][0][:temp][:max]).to be_a Numeric
      expect(weather_data[:daily][0][:temp][:min]).to be_a Numeric
      expect(weather_data[:daily][0][:weather]).to be_an Array
      expect(weather_data[:daily][0][:weather][0]).to be_a Hash
      expect(weather_data[:daily][0][:weather][0][:description]).to be_a String
      expect(weather_data[:daily][0][:weather][0][:icon]).to be_a String

      expect(weather_data[:hourly]).to be_an Array
      expect(weather_data[:hourly][0][:dt]).to be_an Integer
      expect(weather_data[:hourly][0][:temp]).to be_a Numeric
      expect(weather_data[:hourly][0][:weather][0]).to be_a Hash
      expect(weather_data[:hourly][0][:weather][0][:description]).to be_a String
      expect(weather_data[:hourly][0][:weather][0][:icon]).to be_a String
    end
  end
end
