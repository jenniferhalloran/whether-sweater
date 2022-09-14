# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coordinates do
  it 'exists and has readable attributes' do
    geodata = JSON.parse(File.read('./spec/fixtures/geodata.json'), symbolize_names: true)[:results][0][:locations][0]

    coordinates = Coordinates.new(geodata)

    expect(coordinates.latitude).to eq(39.738453)
    expect(coordinates.longitude).to eq(-104.984853)
  end
end
