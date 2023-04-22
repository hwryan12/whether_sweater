require 'rails_helper'

RSpec.describe 'GET /api/v0/forecast', type: :request do
  context 'when the location is valid' do
    it 'returns the weather for the location', :vcr do
      location_city = "Houston"
      location_state = "TX"
      get "/api/v0/forecast?location=#{location_city},#{location_state}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to be_nil
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('forecast')
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)
    
    # Current Weather
      expect(json_response[:data][:attributes]).to have_key(:current_weather)
      expect(json_response[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(json_response[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(json_response[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(json_response[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(json_response[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(json_response[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(json_response[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(json_response[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(json_response[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(json_response[:data][:attributes][:current_weather][:icon]).to be_a(String)
    
    # Daily Weather
      expect(json_response[:data][:attributes]).to have_key(:daily_weather)
      expect(json_response[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(json_response[:data][:attributes][:daily_weather].count).to eq(5)
      json_response[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a(Hash)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a(String)
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
      end
    
    # Hourly Weather 
      expect(json_response[:data][:attributes]).to have_key(:hourly_weather)
      expect(json_response[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(json_response[:data][:attributes][:hourly_weather].count).to eq(24)
      json_response[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to be_a(Hash)
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)
      end
    end
  end
end