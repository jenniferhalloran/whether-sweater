# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      before_action :validate_location

      def index
        coordinates = GeocodingFacade.get_coordinates(params[:location])
        weather = WeatherFacade.get_weather(coordinates.latitude, coordinates.longitude)

        render json: ForecastSerializer.format_forecast(weather), status: :ok
      end
    end
  end
end
