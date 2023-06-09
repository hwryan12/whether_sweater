require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  context 'instance methods' do
    describe '#get_road_trip' do
      context 'when travel is possible' do
        let!(:origin) { 'Denver, CO' }
        let!(:destination) { 'Pueblo, CO' }
        
        it 'returns a road trip object with valid travel time and weather' do
          VCR.use_cassette('road_trip_facade') do
            road_trip = RoadTripFacade.new.get_road_trip(origin, destination)
            
            expect(road_trip).to be_a(RoadTrip)
            expect(road_trip.start_city).to eq(origin)
            expect(road_trip.end_city).to eq(destination)
            expect(road_trip.travel_time).to be_a(String)
            expect(road_trip.travel_time).to_not be_empty
            expect(road_trip.weather_at_eta).to be_a(Hash)
            expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
            expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
            expect(road_trip.weather_at_eta[:condition]).to be_a(String)
          end
        end
      end

      context 'when travel is impossible' do
        let!(:origin) { 'New York, NY' }
        let!(:destination) { 'London, UK' }

        it 'returns a road trip object with "impossible" travel time and empty weather' do
          VCR.use_cassette('impossible_road_trip_facade') do
            road_trip = RoadTripFacade.new.get_road_trip(origin, destination)

            expect(road_trip).to be_a(RoadTrip)
            expect(road_trip.start_city).to eq(origin)
            expect(road_trip.end_city).to eq(destination)
            expect(road_trip.travel_time).to eq("impossible")
            expect(road_trip.weather_at_eta).to eq({})
          end
        end
      end
    end
  end
end
