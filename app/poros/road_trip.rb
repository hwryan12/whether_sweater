class RoadTrip
  attr_reader :id, 
              :type, 
              :start_city, 
              :end_city,
              :travel_time,
              :weather_at_eta
  
  def initialize(origin, destination, directions, forecast)
    @id = nil
    @start_city = origin
    @end_city = destination
    if directions.nil? && forecast.nil?
      @travel_time = "impossible"
      @weather_at_eta = {}
    else
      @travel_time = directions[:route][:formattedTime]
      @weather_at_eta = {
        datetime: forecast[:time],
        temperature: forecast[:temp_f],
        condition: forecast[:condition][:text]
      }
    end
  end
end