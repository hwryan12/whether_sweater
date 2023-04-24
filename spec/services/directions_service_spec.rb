require 'rails_helper'

describe 'DirectionsService' do
  context 'instance methods' do
    context '#get_directions' do
      it 'returns the directions for a start point to end point' do
        VCR.use_cassette('directions_service') do
          origin = 'Girdwood, AK'
          destination = 'Whittier, AK'
          json_response = DirectionsService.new.get_directions(origin, destination)
          
          expect(json_response).to be_a(Hash)
          expect(json_response[:route]).to be_a(Hash)
          expect(json_response[:route][:locations]).to be_an(Array)
          
          json_response[:route][:locations].each do |location|
          expect(location).to be_a(Hash)
          expect(location[:adminArea5]).to be_a(String)
          expect(location[:adminArea3]).to be_a(String)
          end

          expect(json_response[:route][:formattedTime]).to be_a(String)
        end
      end
    end
  end
end