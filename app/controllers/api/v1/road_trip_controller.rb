module Api
  module V1
    class RoadTripController < ApplicationController
      include ParamsHelper
      before_action :validate_inputs, only: [:show]

      def show
        route = GeocodingFacade.get_route(params[:origin], params[:destination])
        if route == "impossible route"
          render json: RoadTripSerializer.format_impossible_trip(params[:origin], params[:destination])
        else
          weather = WeatherFacade.get_weather_at_eta(route.end_latitude, route.end_longitude, route.hours_to_destination)
          render json: RoadTripSerializer.format_roadtrip(route, weather)
        end
      end
    end
  end
end