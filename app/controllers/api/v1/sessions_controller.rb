class Api::V1::SessionsController < ApplicationController
  include ParamsHelper
  include AuthHelper
  before_action :downcase_email_params
  
  def create
    user = User.find_by(email: params[:email])
    if authenticated(user)
      render json: UserSerializer.register_user(user, api_key(user)), status: 200
    else
      render json: ErrorSerializer.format_error(error), status: 401
    end
  end


private

  def error
    "Those credentials are incorrect. Try again!"
  end
end