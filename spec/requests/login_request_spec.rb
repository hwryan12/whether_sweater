require 'rails_helper'

RSpec.describe 'POST /api/v0/sessions', type: :request do
  context 'when the request is valid' do
    let!(:registered_user) { create(:user, email: 'whatever@example.com', password: 'password', password_confirmation: 'password') }

    it 'returns the user with an api key and a 200 code' do
      post '/api/v0/sessions', params: { email: registered_user.email, password: registered_user.password }, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:type]).to eq('users')
      expect(json_response[:data][:id].to_i).to eq(registered_user.id)
      expect(json_response[:data][:attributes]).to be_a(Hash)
      expect(json_response[:data][:attributes][:email]).to eq(registered_user.email)
      expect(json_response[:data][:attributes][:api_key]).to eq(registered_user.api_key)
    end
  end

  context 'sad path' do
    let!(:registered_user) { create(:user, email: 'whatever@example.com', password: 'password', password_confirmation: 'password') }

    it 'returns a 401 status code and error message when the password is incorrect' do
      post '/api/v0/sessions', params: { email: registered_user.email, password: 'wrong_password' }, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:unauthorized)
      expect(json_response[:error]).to eq('Invalid credentials')
    end

    it 'returns a 401 status code and error message when the email is unregistered' do
      post '/api/v0/sessions', params: { email: 'unregistered@example.com', password: 'password' }, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:unauthorized)
      expect(json_response[:error]).to eq('Invalid credentials')
    end
  end
end