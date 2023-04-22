require 'rails_helper'

describe 'WeatherApiService' do
  context 'instance methods' do
    context '#get_forecast' do
      it 'returns forecast for a location' do
        VCR.use_cassette('weather_api_service') do
          lat = 29.76078
          lng = -95.36952

          response = WeatherApiService.new.get_forecast(lat, lng)

          expect(response).to be_a(Hash)
          expect(response).to have_key(:location)
          expect(response[:location]).to be_a(Hash)
          expect(response).to have_key(:current)
          expect(response[:current]).to be_a(Hash)
          expect(response[:current]).to have_key(:last_updated)
          expect(response[:current][:last_updated]).to be_a(String)
          expect(response[:current]).to have_key(:temp_f)
          expect(response[:current][:temp_f]).to be_a(Float)
          expect(response[:current]).to have_key(:feelslike_f)
          expect(response[:current][:feelslike_f]).to be_a(Float)
          expect(response[:current]).to have_key(:humidity)
          expect(response[:current][:humidity]).to be_a(Integer)
          expect(response[:current]).to have_key(:uv)
          expect(response[:current][:uv]).to be_a(Float)
          expect(response[:current]).to have_key(:vis_miles)
          expect(response[:current][:vis_miles]).to be_a(Float)
          expect(response[:current]).to have_key(:condition)
          expect(response[:current][:condition]).to be_a(Hash)
          expect(response[:current][:condition]).to have_key(:text)
          expect(response[:current][:condition][:text]).to be_a(String)
          expect(response[:current][:condition]).to have_key(:icon)
          expect(response[:current][:condition][:icon]).to be_a(String)
        end
      end
    end
  end
end