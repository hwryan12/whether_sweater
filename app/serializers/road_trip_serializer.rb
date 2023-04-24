class RoadTripSerializer
  def initialize(data)
    @data = data
  end

  def serialize_road_trip
    if @data.nil?
      { error: 'No data found' }
    else
      {
        data: {
          id: nil,
          type: 'road_trip',
          attributes:
          {
            start_city: @data.start_city,
            end_city: @data.end_city,
            travel_time: @data.travel_time,
            weather_at_eta: {
              datetime: @data.weather_at_eta[:datetime],
              temperature: @data.weather_at_eta[:temperature],
              condition: @data.weather_at_eta[:condition]
            }
          }
        }
      }
    end
  end
end
