require 'rails_helper'

RSpec.describe RoadTrip do
  let!(:directions_data) do
    {
      route: {
        locations: [
          {
            adminArea5: "Denver",
            adminArea3: "CO"
          },
          {
            adminArea5: "Pueblo",
            adminArea3: "CO"
          }
        ],
        formattedTime: "01:44:37"
      }
    }
  end
  let!(:forecast_data) do
    {
      time: "2023-04-22 00:00",
      temp_f: 65.0,
      condition: {
        text: "Partly cloudy"
      }
    }
  end

  describe 'instantiation' do
    let!(:road_trip) { RoadTrip.new(directions_data, forecast_data) }
    it 'exists' do
      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.type).to eq('road_trip')
      expect(road_trip.start_city).to eq('Denver, CO')
      expect(road_trip.end_city).to eq('Pueblo, CO')
      expect(road_trip.travel_time).to eq('01:44:37')
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta[:datetime]).to eq('2023-04-22 00:00')
      expect(road_trip.weather_at_eta[:temperature]).to eq(65.0)
      expect(road_trip.weather_at_eta[:condition]).to eq('Partly cloudy')
    end
  end
end