require 'rails_helper'

RSpec.describe 'POST /api/v0/sessions', type: :request do
  context 'when the request is valid' do
    let!(:user) { create(:user, email: 'whatever@example.com', password: 'password', password_confirmation: 'password') }
    it 'returns the user with an api key and a 200 code' do
      post '/api/v0/sessions', params: { email: user.email, password: user.password }, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json
      
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:id].to_i).to eq(user.id)
      expect(json_response[:data][:attributes][:email]).to eq(user.email)
      expect(json_response[:data][:attributes][:api_key]).to eq(user.api_key)
    end
  end
end