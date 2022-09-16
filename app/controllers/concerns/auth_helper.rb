module AuthHelper 
  def validate_api_key
    api_key = ApiKey.find_by(token: params[:api_key])
    invalid_api_key if !api_key
  end

  def invalid_api_key
    render json: ErrorSerializer.format_error(api_error), status: 401
  end

  def api_error 
    "Invalid API key."
  end

  def invalid_credentials(user)
    error = user.errors.full_messages.to_sentence
    render json: ErrorSerializer.format_error(error), status: 400
  end

  def authenticated(user)
    user && user.authenticate(params[:password])
  end

  def api_key(user)
    user.api_keys.first
  end

end