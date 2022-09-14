require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'happy path' do
    it 'creates a new user' do
      params = {
        "email": 'whatever@example.com',
        "password": 'password',
        "password_confirmation": 'password'
      }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(body).to have_key("data")
      expect(body["data"]).to have_key("type")
      expect(body["data"]).to have_key("id")
      expect(body["data"]).to have_key("attributes")
      expect(body["data"]["attributes"]).to have_key("email")
      expect(body["data"]["attributes"]).to have_key("api_key")
    end
  end

  describe 'sad path' do
    it 'returns that an email is already taken with a 400 status' do
      User.create(email: 'whatever@example.com', password: 'supersecret')
      params = {
        "email": 'whatever@example.com',
        "password": 'password',
        "password_confirmation": 'password'
      }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(params)
      
      body = JSON.parse(response.body)
      
      expect(response.status).to eq(400)
      expect(body["data"]["error"]).to eq("Email has already been taken")
    end
    
    it 'returns that a password confirmation must match password error with a 400 status' do
      params = {
        "email": 'whatever@example.com',
        "password": 'password',
        "password_confirmation": 'passwor'
      }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(params)
      
      body = JSON.parse(response.body)
      
      expect(response.status).to eq(400)
      expect(body["data"]["error"]).to eq("Password confirmation doesn't match Password")
    end

    it 'returns a field cant be blank message error with a 400 status' do
      params = {
        "password": 'password',
        "password_confirmation": 'password'
      }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(params)
      
      body = JSON.parse(response.body)
      
      expect(response.status).to eq(400)
      expect(body["data"]["error"]).to eq("Email can't be blank")
    end
  end
end 