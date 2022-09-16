module ParamsHelper 
  include ErrorHelper
  
  def downcase_email_params
    params[:email] = user_params[:email].downcase if params[:email]
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  
  def validate_location 
    invalid_search if params[:location].nil? || params[:location].strip == ""
  end

  def invalid_origin
    params[:origin].nil? || params[:origin].strip == ""
  end

  def invalid_destination
    params[:destination].nil? || params[:destination].strip == ""
  end

  def validate_inputs 
    if invalid_origin
      invalid_search
    elsif invalid_destination
      invalid_search
    end
  end

  def invalid_search
    render json: ErrorSerializer.format_error(search_error), status: 400 
  end

end