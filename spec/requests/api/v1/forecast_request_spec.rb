# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'happy path' do
    it 'sends the current weather for a given city' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data][:attributes]).to be_a Hash

      expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a String
      expect(forecast[:data][:attributes][:current_weather][:sunrise]).to be_a String
      expect(forecast[:data][:attributes][:current_weather][:sunset]).to be_a String
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a Float
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a Float
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a Numeric
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a Numeric
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a Numeric
      expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a String
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a String
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key :wind_speed
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key :wind_deg
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key :wind_gust

      expect(forecast[:data][:attributes][:daily_weather]).to be_an Array
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
      forecast[:data][:attributes][:daily_weather].each do |forecast|
        expect(forecast[:date]).to be_a String
        expect(forecast[:sunrise]).to be_a String
        expect(forecast[:sunset]).to be_a String
        expect(forecast[:max_temp]).to be_a Float
        expect(forecast[:min_temp]).to be_a Float
        expect(forecast[:conditions]).to be_a String
        expect(forecast[:icon]).to be_a String
        expect(forecast).to_not have_key :moonset
        expect(forecast).to_not have_key :moonrise
        expect(forecast).to_not have_key :moon_phase
        expect(forecast).to_not have_key :feels_like
        expect(forecast).to_not have_key :pressure
      end

      expect(forecast[:data][:attributes][:hourly_weather]).to be_an Array
      expect(forecast[:data][:attributes][:hourly_weather].count).to eq 8
      forecast[:data][:attributes][:hourly_weather].each do |forecast|
        expect(forecast[:time]).to be_a String
        expect(forecast[:temperature]).to be_a Float
        expect(forecast[:conditions]).to be_a String
        expect(forecast[:icon]).to be_a String
        expect(forecast).to_not have_key :feels_like
        expect(forecast).to_not have_key :dew_point
        expect(forecast).to_not have_key :clouds
        expect(forecast).to_not have_key :visibility
      end
    end
    it 'saves the geolocation of the city given to the database and does not save it again if it exists' do
      expect(Geolocation.all.count).to eq(0)
      get '/api/v1/forecast?location=denver,co'
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(Geolocation.all.count).to eq(1)

      get '/api/v1/forecast?location=denver,co'
      
      expect(Geolocation.all.count).to eq(1)
    end 

  end

  describe 'sad path' do
    it 'returns an error if there are no params sent through' do
      get '/api/v1/forecast'

      expect(response.status).to eq 400

      get '/api/v1/forecast?location=  '
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(body[:data][:error]).to eq('Invalid search, please try again.')
    end
  end
end
