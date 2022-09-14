class Coordinates 
  attr_reader :latitude, :longitude

  def initialize(geodata)
    @latitude = geodata[:latLng][:lat]
    @longitude = geodata[:latLng][:lng]
  end
end