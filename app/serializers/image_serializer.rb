class ImageSerializer
  include JSONAPI::Serializer

  set_id :id

  attributes :url, :description, :photographer, :photographer_profile
end
