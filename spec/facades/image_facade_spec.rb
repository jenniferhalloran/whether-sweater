# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageFacade do
  describe '#get_image_by_keyword(query)' do
    it 'returns an image object' do
      image = ImageFacade.get_image_by_keyword('denver,co')

      expect(image).to be_an(Image)

      expect(image.url).to be_a(String)
      expect(image.description).to be_a(String)
      expect(image.photographer).to be_a(String)
      expect(image.photographer_profile).to be_a(String)
    end
  end
end
