class GeocodeService
  def get_location(location)
    get_url("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
  end

  def get_coordinates(location)
    location_data = get_location(location)
    location_data[:results].first[:locations].first[:latLng]
  end
  
  private

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
      faraday.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end