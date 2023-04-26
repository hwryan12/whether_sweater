require 'rails_helper'

RSpec.describe 'POST /api/v0/road_trip', type: :request do 
  let!(:user) { create(:user, email: 'whatever@example.com', password: 'password', password_confirmation: 'password') }
  let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json', 'HTTP_API_KEY': user.api_key } }
  
  context 'when the request is valid' do
    let(:valid_params) do
      {
        origin: 'Houston, TX',
        destination: 'Whittier, AK',
        api_key: user.api_key
      }
    end
    
    it 'returns the road trip with the forecast and a 200 code' do
      VCR.use_cassette('road_trip_with_forecast') do
        post '/api/v0/road_trip', params: valid_params, headers: headers, as: :json
    
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        
        json_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(json_response).to be_a(Hash)
        expect(json_response[:data]).to be_a(Hash)
        expect(json_response[:data][:id]).to be_nil
        expect(json_response[:data][:type]).to eq('road_trip')
        expect(json_response[:data][:attributes]).to be_a(Hash)
        expect(json_response[:data][:attributes][:start_city]).to eq(valid_params[:origin])
        expect(json_response[:data][:attributes][:end_city]).to eq(valid_params[:destination])
        expect(json_response[:data][:attributes][:travel_time]).to be_a(String)
        expect(json_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(json_response[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
        expect(json_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(json_response[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end
    end
  end

  context 'when the request is invalid - no API key' do
    let(:invalid_params) do
      {
        origin: 'Houston, TX',
        destination: 'Whittier, AK',
        api_key: nil
      }
    end
    
    it 'returns a 401 status code' do
      VCR.use_cassette('road_trip_with_forecast') do
        post '/api/v0/road_trip', params: invalid_params, headers: headers, as: :json
        
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end


  context 'when the request is invalid - missing locations' do
    let!(:invalid_params) do
      {
        origin: '',
        destination: '',
        api_key: user.api_key
      }
    end
    
    it 'returns a 400 status code', :vcr do
      post '/api/v0/road_trip', params: invalid_params, headers: headers, as: :json

      expect(response).to have_http_status(:bad_request)
    end
  end
end 