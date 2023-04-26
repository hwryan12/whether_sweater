require 'rails_helper'

RSpec.describe 'POST /api/v0/users', type: :request do
  context 'when the request is valid' do
    let!(:user_params) do
      {
        email: 'email@email.com',
        password: 'password',
        password_confirmation: 'password'
      }
    end

    it 'creates a new user returns a 201 code' do
      post '/api/v0/users', params: user_params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to be_a(Integer)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('users')
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)
      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes][:email]).to be_a(String)
      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:api_key]).to be_a(String)
    end
  end
  
  context 'when the request is invalid - passwords mismatch' do
    let!(:user_params) do
      {
        user: {
          email: 'email@email.com',
          password: 'password',
          password_confirmation: 'wrong_password'
        }
      }
    end
    
    it 'returns a 422 code and an error message when the passwords do not match' do
      post '/api/v0/users', params: user_params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json
  
      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(json_response[:error]).to eq("Password can't be blank, Email can't be blank, Password can't be blank, and Password confirmation can't be blank")
    end
  end

  context 'when the request is invalid - existing email' do
    let!(:existing_user) { create(:user, email: 'email@email.com', password: '12345', password_confirmation: '12345') }
    let!(:user_params) do
      {
        user: {
          email: 'email@email.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    
    it 'returns a 422 code and an error message when the email already exists' do
      post '/api/v0/users', params: user_params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }, as: :json
  
      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:unprocessable_entity) 
      expect(json_response[:error]).to eq("Password can't be blank, Email can't be blank, Password can't be blank, and Password confirmation can't be blank")
    end
  end
end