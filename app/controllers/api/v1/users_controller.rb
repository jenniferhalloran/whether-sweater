# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include ParamsHelper
      def create
        user = User.create(user_params)
        if user.save
          api_key = user.api_keys.create! token: SecureRandom.hex
          render json: UserSerializer.register_user(user, api_key), status: 201
        else
          error = user.errors.full_messages.to_sentence.to_s
          render json: ErrorSerializer.format_error(error), status: 400
        end
      end
    end
  end
end