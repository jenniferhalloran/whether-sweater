# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image do
  it 'exists and has readable attributes' do
    image_data = JSON.parse(File.read('./spec/fixtures/image.json'), symbolize_names: true)[:results][0]

    image = Image.new(image_data)
    expect(image.url).to eq("https://images.unsplash.com/photo-1573297627466-6bed413a43f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjQ4Mjd8MHwxfHNlYXJjaHwxfHxkZW52ZXJ8ZW58MHwwfHx8MTY2MzM3NjkwNA&ixlib=rb-1.2.1&q=80&w=1080")
    expect(image.description).to eq("Denver street artowrk")
    expect(image.photographer).to eq("Pieter van de Sande")
    expect(image.photographer_profile).to eq("https://unsplash.com/@planner1963")
  end
end
