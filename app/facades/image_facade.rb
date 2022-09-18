class ImageFacade 
  def self.get_image_by_keyword(query)
    data = ImageService.get_image_by_keyword(query)
    Image.new(data[:results][0])
  end
end