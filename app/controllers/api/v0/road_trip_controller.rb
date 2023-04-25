class Api::V0::RoadTripController < ApplicationController
  def create 
    user = User.find_by(api_key: params[:api_key])
    if user && valid_origin_destination?
      road_trip = RoadTripFacade.new.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip).serialize_road_trip
    elsif user.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    else
      render json: { error: 'Bad Request' }, status: :bad_request
    end
  end

  private

  def valid_origin_destination?
    params[:origin].present? && params[:destination].present?
  end
end