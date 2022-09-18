require 'rails_helper'
RSpec.describe 'User Log In' do
  describe 'happy path' do
    it 'returns user info and a 200 status when credentials are valid' do
      user = User.create(email: 'whatever@example.com', password: 'supersecret')
      user.api_keys.create!(token: "testapikey")

      params = {
        "email": "wHAtever@example.com",
        "password": "supersecret"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)
      body = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(body).to have_key("data")
      expect(body["data"]).to have_key("type")
      expect(body["data"]).to have_key("id")
      expect(body["data"]).to have_key("attributes")
      expect(body["data"]["attributes"]).to have_key("email")
      expect(body["data"]["attributes"]).to have_key("api_key")
    end
  end
  describe 'sad path' do
    it "returns a bad credentials error and 400 status if user doesn't exist" do

      params = {
        "email": "whatever@example.com",
        "password": "supersecret"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(body["data"]["error"]).to eq("Those credentials are incorrect. Try again!")
    end
    it "returns a bad credentials error and 400 status if user password doesn't match" do
      user = User.create(email: 'whatever@example.com', password: 'supersquirrel')
      user.api_keys.create!(token: "testapikey")

      params = {
        "email": "whatever@example.com",
        "password": "supersecret"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(body["data"]["error"]).to eq("Those credentials are incorrect. Try again!")
    end
  end
end