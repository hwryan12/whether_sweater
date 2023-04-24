class TeleportService
  def get_city_salaries(city)
    get_url("/api/urban_areas/slug:#{city.parameterize}/salaries/")
  end

  private

  def conn
    Faraday.new(url: 'https://api.teleport.org')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end