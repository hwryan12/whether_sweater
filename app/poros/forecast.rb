class Forecast
  attr_reader :id, 
              :current_weather, 
              :daily_weather, 
              :hourly_weather
  
  def initialize(weather_data)
    @id = nil
    @current_weather = extract_current_weather(weather_data)
    @daily_weather = extract_daily_weather(weather_data)
    @hourly_weather = extract_hourly_weather(weather_data)
  end

  private

  def extract_current_weather(data)
    {
      last_updated: human_readable_time(data[:current][:last_updated_epoch]),
      temperature: data[:current][:temp_f],
      feels_like: data[:current][:feelslike_f],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uv],
      visibility: data[:current][:vis_miles],
      condition: data[:current][:condition][:text],
      icon: data[:current][:condition][:icon]
    }
  end

  def extract_daily_weather(data)
    data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def extract_hourly_weather(data)
    data[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: human_readable_time_24_hour_clock(hour[:time]),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end

  def human_readable_time(epoch)
    Time.at(epoch).strftime("%Y-%m-%d %H:%M")
  end

  def human_readable_time_24_hour_clock(time)
    Time.strptime(time, "%Y-%m-%d %H:%M").strftime("%H:%M")
  end
end