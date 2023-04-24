require 'rails_helper'

describe 'TeleportService' do
  context 'instance methods' do
    context '#get_city_salaries' do
      it 'returns the salaries for a city' do
        VCR.use_cassette('teleport_service') do
          city = 'Denver'
          json_response = TeleportService.new.get_city_salaries(city)

          expect(json_response).to be_a(Hash)
          expect(json_response[:salaries]).to be_a(Array)
          
          json_response[:salaries].each do |data|
          expect(data).to be_a(Hash)
          expect(data[:job][:title]).to be_a(String)
          expect(data[:salary_percentiles][:percentile_25]).to be_a(Float)
          expect(data[:salary_percentiles][:percentile_75]).to be_a(Float)
          end
        end
      end
    end
  end
end