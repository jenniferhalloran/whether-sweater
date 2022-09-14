class Api::V1::ForecastController < ApplicationController
  before_action :validate_location
  
  def index
    coordinates = GeocodingFacade.get_coordinates(params[:location])
    weather = WeatherFacade.get_weather(coordinates.latitude, coordinates.longitude)

    render json: ForecastSerializer.format_forecast(weather)
  end
end