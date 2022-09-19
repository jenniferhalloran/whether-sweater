require 'rails_helper'

RSpec.describe "Image API" do
  describe 'happy path' do
    it 'returns an image relevant to the keyword sent' do
      get '/api/v1/images?keyword=denver,co' 
      body = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(body).to have_key("data")
      expect(body["data"]).to have_key("type")
      expect(body["data"]).to have_key("id")
      expect(body["data"]).to have_key("attributes")
      expect(body["data"]["attributes"]).to have_key("url")
      expect(body["data"]["attributes"]).to have_key("description")
      expect(body["data"]["attributes"]).to have_key("photographer")
      expect(body["data"]["attributes"]).to have_key("photographer_profile")
    end
  end 
end 