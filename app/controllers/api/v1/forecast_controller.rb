# frozen_string_literal: true

class Api::V1::ForecastController < ApplicationController
  include ParamsHelper
  before_action :validate_location

  def index
    location = params[:location]
    if new_location?(location)
      coordinates = GeocodingFacade.get_coordinates(location)
      store_location(location, coordinates)
    else
      coordinates = Geolocation.find_by(location: params[:location])
    end

    Rails.cache.write('weather', WeatherFacade.get_weather(coordinates.latitude, coordinates.longitude))
    cached_weather = Rails.cache.fetch('weather')
    render json: ForecastSerializer.format_forecast(cached_weather), status: :ok
  end

  private 

  def new_location?(location)
    Geolocation.find_by(location: location).nil?
  end

  def store_location(location, coordinates)
    Geolocation.create(location: location, latitude: coordinates.latitude, longitude: coordinates.longitude)
  end
end

