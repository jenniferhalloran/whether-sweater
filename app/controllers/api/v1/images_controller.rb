class Api::V1::ImagesController < ApplicationController
  def index
    image = ImageFacade.get_image_by_keyword(params[:keyword])
    render json: ImageSerializer.new(image), status: :ok
  end
end