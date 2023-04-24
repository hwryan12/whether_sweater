require 'rails_helper'

describe 'GeocodeService' do
  context 'instance methods' do
    context '#get_location' do
      it 'returns the location data' do
        VCR.use_cassette('geocode_service') do
          location = 'Houston, TX'
          response = GeocodeService.new.get_location(location)

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

      it 'returns the coordinates for a location' do
        VCR.use_cassette('mapquest_service') do
          location = 'Houston, TX'
          response = GeocodeService.new.get_coordinates(location)

          expect(response).to be_a(Hash)
          expect(response).to have_key(:lat)
          expect(response[:lat]).to be_a(Float)
          expect(response).to have_key(:lng)
          expect(response[:lng]).to be_a(Float)
        end
      end
    end
  end
end