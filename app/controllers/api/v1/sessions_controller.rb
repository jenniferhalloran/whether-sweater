class Api::V1::SessionsController < ApplicationController
  include ParamsHelper
  before_action :downcase_email_params
  
  def create
    if authenticated 
      render json: UserSerializer.register_user(user, api_key(user)), status: 200
    else
      render json: ErrorSerializer.format_error(error), status: 401
    end
  end


  private 
  def authenticated
    user && user.authenticate(params[:password])
  end

  def user
    user = User.find_by(email: params[:email])
  end

  def api_key(user)
    user.api_keys.first
  end

  def error
    "Those credentials are incorrect. Try again!"
  end
end