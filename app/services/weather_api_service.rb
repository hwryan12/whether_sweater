class WeatherApiService
  def get_forecast(lat, lng)
    get_url( "forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{lat}, #{lng}&days=5")
  end

  private

  def conn
    Faraday.new(url: 'http://api.weatherapi.com/v1') do |faraday|
      faraday.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end