class Api::V1::ForecastController < ApplicationController
  def index
    coordinates = GeocodingFacade.get_coordinates(params[:location])
    require 'pry'; binding.pry
    # render json: ForecastSerializer.
  end
end