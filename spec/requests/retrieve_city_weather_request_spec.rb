require 'rails_helper'

RSpec.describe 'GET /api/v0/forecast', type: :request do
  context 'when the location is valid' do
    it 'returns the weather for the location' do
      location = create(:location)
      get "/api/v0/forecast?location=#{location.city},#{location.state}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response.body).to include(location.city)
      expect(response.body).to include(location.state)
    end
  end
end