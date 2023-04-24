class RoadTrip
  attr_reader :id, 
              :type, 
              :start_city, 
              :end_city,
              :travel_time,
              :weather_at_eta
  
  def initialize(directions, forecast)
    @id = nil
    @type = 'road_trip'
    @start_city = directions[:route][:locations][0][:adminArea5] + ', ' + directions[:route][:locations][0][:adminArea3]
    @end_city = directions[:route][:locations][1][:adminArea5] + ', ' + directions[:route][:locations][1][:adminArea3]
    @travel_time = directions[:route][:formattedTime]
    @weather_at_eta = format_forcast(forecast)
  end

  private

  def format_forcast(forecast)
    {
      datetime: forecast[:time],
      temperature: forecast[:temp_f],
      condition: forecast[:condition][:text]
    }
  end
end