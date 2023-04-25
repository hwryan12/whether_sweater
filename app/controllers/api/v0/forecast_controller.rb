class Api::V0::ForecastController < ApplicationController
  before_action :set_headers
  
  def index
    if params[:location].nil? || params[:location] == '' || params[:location] == ','
      render json: { error: 'Please provide a valid location' }, status: :bad_request
    else
      coordinates = GeocodeService.new.get_coordinates(params[:location])
      weather = WeatherApiService.new.get_forecast(coordinates[:lat], coordinates[:lng])
      forecast = Forecast.new(weather)
      render json: ForecastSerializer.new(forecast).serialize_weather
    end
  end

  private

  def set_headers
    request.format = :json
  end
end