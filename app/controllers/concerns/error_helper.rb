module ErrorHelper

  def search_error
    "Invalid search, please try again."
  end

  def key_error 
    "Invalid API key."
  end

  def authentication_error
    "Those credentials are incorrect. Try again!"
  end

  # def user_error(user)
  #   user.errors.full_messages.to_sentence.to_s
  # end

end