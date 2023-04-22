require 'rails_helper'

describe 'MapquestService' do
  context 'instance methods' do
    context '#get_coordinates' do
      it 'returns coordinates for a location' do
        VCR.use_cassette('mapquest_service') do
          location = 'Houston, TX'
          response = MapquestService.new.get_coordinates(location)

          expect(response).to be_a(Hash)
          expect(response).to have_key(:results)
          expect(response[:results]).to be_an(Array)
          expect(response[:results].first).to have_key(:locations)
          expect(response[:results].first[:locations]).to be_an(Array)
          expect(response[:results].first[:locations][0]).to have_key(:latLng)
          expect(response[:results].first[:locations][0][:latLng]).to be_a(Hash)
          expect(response[:results].first[:locations][0][:latLng]).to have_key(:lat)
          expect(response[:results].first[:locations][0][:latLng][:lat]).to be_a(Float)
          expect(response[:results].first[:locations][0][:latLng]).to have_key(:lng)
          expect(response[:results].first[:locations][0][:latLng][:lng]).to be_a(Float)
        end
      end
    end
  end
end