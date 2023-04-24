require 'rails_helper'


RSpec.describe 'GET /api/v1/salaries?destination=:location', type: :request do
  context 'when the request is valid' do
    it 'returns the salary with a 200 code' do
      VCR.use_cassette('salary_with_location') do
        city = 'Houston, TX'
        get "/api/v1/salaries?destination=#{city}"
        json_response = JSON.parse(response.body, symbolize_names: true)
      
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(json_response).to be_a(Hash)
        expect(json_response[:data]).to be_a(Hash)
        expect(json_response[:data][:id]).to be_nil
        expect(json_response[:data][:type]).to eq('salaries')
        expect(json_response[:data][:attributes]).to be_a(Hash)
        expect(json_response[:data][:attributes][:destination]).to be_a(String)
        expect(json_response[:data][:attributes][:forecast]).to be_a(Hash)
        expect(json_response[:data][:attributes][:forecast][:summary]).to be_a(String)
        expect(json_response[:data][:attributes][:forecast][:temperature]).to be_a(String)
        expect(json_response[:data][:attributes][:salaries]).to be_an(Array)
        json_response[:data][:attributes][:salaries].each do |job|
          expect(job[:title]).to be_a(String)
          expect(job[:min]).to be_a(String)
          expect(job[:max]).to be_a(String)
        end
      end
    end
  end
end