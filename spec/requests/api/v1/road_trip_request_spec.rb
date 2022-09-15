require 'rails_helper'

RSpec.describe 'Roadtrip API' do
  describe 'happy path' do
    it 'returns road trip information and weather for a trip under 48 hours' do

      user = User.create(email: 'whatever@example.com', password: 'supersecret')
      user.api_keys.create!(token: "jgn983hy48thw9begh98h4539h4")

      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body).to have_key("data")
      expect(body["data"]).to have_key("type")
      expect(body["data"]).to have_key("id")
      expect(body["data"]).to have_key("attributes")
      expect(body["data"]["attributes"]).to have_key("start_city")
      expect(body["data"]["attributes"]).to have_key("end_city")
      expect(body["data"]["attributes"]).to have_key("travel_time")
      expect(body["data"]["attributes"]).to have_key("weather_at_eta")
      expect(body["data"]["attributes"]["weather_at_eta"]).to have_key("temperature")
      expect(body["data"]["attributes"]["weather_at_eta"]).to have_key("conditions")
    end

    it 'returns road trip information and weather for a trip over 48 hours' do

      user = User.create(email: 'whatever@example.com', password: 'supersecret')
      user.api_keys.create!(token: "jgn983hy48thw9begh98h4539h4")

      params = {
        "origin": "New York, NY",
        "destination": "Panama City, Panama",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body).to have_key("data")
      expect(body["data"]).to have_key("type")
      expect(body["data"]).to have_key("id")
      expect(body["data"]).to have_key("attributes")
      expect(body["data"]["attributes"]).to have_key("start_city")
      expect(body["data"]["attributes"]).to have_key("end_city")
      expect(body["data"]["attributes"]).to have_key("travel_time")
      expect(body["data"]["attributes"]).to have_key("weather_at_eta")
      expect(body["data"]["attributes"]["weather_at_eta"]).to have_key("temperature")
      expect(body["data"]["attributes"]["weather_at_eta"]).to have_key("conditions")
    end

    xit 'returns an impossible route error if a route cannot be made to the destination' do
      user = User.create(email: 'whatever@example.com', password: 'supersecret')
      user.api_keys.create!(token: "jgn983hy48thw9begh98h4539h4")

      params = {
        "origin": "Denver,CO",
        "destination": "London, UK",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body).to have_key(:data)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes][:travel_time]).to eq("Impossible Route")
      expect(body[:data][:attributes][:weather_at_eta]).to eq(nil)
    end
  end
  
  describe 'sad path' do
    it 'returns a 401 status and invalid API key error if API key does not exist' do

      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      body = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(body["error"]).to eq("Invalid API key.")
    end
  end
end