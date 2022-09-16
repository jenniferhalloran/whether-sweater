# frozen_string_literal: true

class Api::V1::ForecastController < ApplicationController
  include ParamsHelper
  before_action :validate_location

  def index
    coordinates = GeocodingFacade.get_coordinates(params[:location])
    Rails.cache.write('weather', WeatherFacade.get_weather(coordinates.latitude, coordinates.longitude))
    cached_weather = Rails.cache.fetch('weather')
    render json: ForecastSerializer.format_forecast(cached_weather), status: :ok
  end

end
