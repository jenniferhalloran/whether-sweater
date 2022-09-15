# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def invalid_search
    render json: { error: 'Invalid search, please try again.' }, status: 400
  end
end
