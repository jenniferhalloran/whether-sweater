class ImageService 
  def self.connection
    Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
      faraday.headers['Authorization'] = ENV['unsplash_key']
      faraday.headers['Accept-Version'] = 'v1'
    end
  end

  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_image_by_keyword(query)
    response = connection.get("search/photos?query=#{query}&orientation=landscape")
    get_json(response)
  end
end