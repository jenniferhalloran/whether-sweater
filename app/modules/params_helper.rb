module ParamsHelper 
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
  
  def validate_location 
    invalid_search if params[:location].nil? || params[:location].strip == ""
  end

  def validate_origin
    invalid_search if params[:origin].nil? || params[:origin].strip == ""
  end

  def validate_destination
    invalid_search if params[:destination].nil? || params[:destination].strip == ""
  end

  def validate_api_key
    api_key = ApiKey.find_by(token: params[:api_key])
    invalid_api_key if !api_key
  end

  def validate_inputs 
    validate_api_key
    validate_origin
    validate_destination
  end

  def invalid_search
    render json: {error: "Invalid search, please try again."}, status: 400 
  end

  def invalid_api_key
    render json: {error: "Invalid API key."}, status: 401
  end

  def invalid_credentials(user)
    render json: {error: user.errors.full_messages.to_sentence}, status: 400
  end


end