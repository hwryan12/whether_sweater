class RoadTripFacade
  def get_road_trip(origin, destination)
    directions = DirectionsService.new.get_directions(origin, destination)
    if directions[:info][:statuscode] == 402 && directions[:info][:messages].include?("We are unable to route with the given locations.")
      RoadTrip.new(origin, destination, nil, nil)
    else
      eta = arrival_time(directions[:route][:formattedTime])
      forecast = get_weather_at_destination(destination, eta)
      RoadTrip.new(origin, destination, directions, forecast)
    end
  end

  private
  
  def arrival_time(travel_time)
    hours, minutes, seconds = travel_time.split(':').map(&:to_i)
    total_seconds = hours * 3600 + minutes * 60 + seconds
    Time.now + total_seconds
  end

  def get_weather_at_destination(destination, arrival_time)
    destination_coords = GeocodeService.new.get_coordinates(destination)
    weather = WeatherApiService.new.get_forecast(destination_coords[:lat], destination_coords[:lng])
    weather_data = weather[:forecast][:forecastday].flat_map { |day| day[:hour] }.find do |hour|
      hourly_time = Time.at(hour[:time_epoch])
      hourly_time >= arrival_time && hourly_time < (arrival_time + 3600)
    end
    weather_data
  end
end