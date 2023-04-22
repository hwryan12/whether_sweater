Class Api::V0::ForecastController < ApplicationController
  def index
    coordinates = LocationFacade.get_coordinates(params[:location])
    weather = WeatherFacade.get_weather(coordinates)
    render json: ForecastSerializer.new(weather)
  end
end