require 'rails_helper'


RSpec.describe 'Forecast API' do
  it 'sends the current weather for a given city' do
    get '/api/v1/forecast'

    expect(response).to be_successful 
  end
end