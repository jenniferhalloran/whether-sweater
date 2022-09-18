class Image 
  attr_reader :url, :description, :photographer, :photographer_profile

  def initialize(data)
    @url = data[:urls][:regular]
    @description = data[:alt_description]
    @photographer = data[:user][:name]
    @photographer_profile = data[:user][:links][:html]
  end
  
end