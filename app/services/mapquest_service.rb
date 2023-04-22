class MapquestService
  def get_coordinates(location)
    get_url("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
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