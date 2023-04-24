class Api::V0::RoadTripController < ApplicationController
  def create 
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.new.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip).serialize_road_trip
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end