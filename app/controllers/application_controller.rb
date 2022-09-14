class ApplicationController < ActionController::API
private
  def validate_location 
    invalid_search if params[:location].nil? || params[:location].strip == ""
  end

  def invalid_search
    render json: {error: "Invalid search, please try again."}, status: 400 
  end
end
