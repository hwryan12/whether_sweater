class DirectionsService
  def get_directions(origin, destination)
    get_url("directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{origin}&to=#{destination}")
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
