class Image 
  attr_reader :url, :description, :photographer, :photographer_profile, :id

  def initialize(data)
    @id = nil
    @url = data[:urls][:regular]
    @description = data[:alt_description]
    @photographer = data[:user][:name]
    @photographer_profile = data[:user][:links][:html]
  end

end