class ForecastFacade
  def get_forecast(location)
    coordinates = GeocodeService.new.get_coordinates(location)
    weather = WeatherApiService.new.get_forecast(coordinates[:lat], coordinates[:lng])
    Forecast.new(weather)
  end
end