class Api::V0::ForecastController < ApplicationController
  def index
    if params[:location].nil? || params[:location] == '' || params[:location] == ','
      render json: { error: 'Please provide a valid location' }, status: :bad_request
    else
      forecast = ForecastFacade.new.get_forecast(params[:location])
      render json: ForecastSerializer.new(forecast).serialize_weather, status: :ok
    end
  end
end