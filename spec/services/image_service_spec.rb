require 'rails_helper'

RSpec.describe ImageService do
  describe '#get_image_by_keyword(query)' do
    it 'returns an image relevant to the keyword used' do
      image_data = ImageService.get_image_by_keyword("denver,co")

      expect(image_data).to be_a Hash
      expect(image_data[:results]).to be_an Array
      expect(image_data[:results][0][:urls][:regular]).to be_a String
      expect(image_data[:results][0][:alt_description]).to be_a String
      expect(image_data[:results][0][:user][:name]).to be_a String
      expect(image_data[:results][0][:user][:links][:html]).to be_a String
    end
  end
 end