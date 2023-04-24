class SalariesFacade
  def get_tech_salaries(location)
    city = remove_state_from_city(location)
    salaries = TeleportService.new.get_city_salaries(city)
    location_coords = GeocodeService.new.get_coordinates(location)
    weather = WeatherApiService.new.get_forecast(location_coords[:lat], location_coords[:lng])
    Salary.new(salaries, weather)
  end
  
  private

  def remove_state_from_city(city_with_state)
    city_with_state.split(',').first.strip
  end
end