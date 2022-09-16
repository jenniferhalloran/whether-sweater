# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  include ParamsHelper
  include AuthHelper
  before_action :downcase_email_params
  
  def create
    user = User.create(user_params)
    if user.save
      api_key = create_key(user)
      render json: UserSerializer.register_user(user, api_key), status: 201
    else
      error = user.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: 400
    end
  end

end