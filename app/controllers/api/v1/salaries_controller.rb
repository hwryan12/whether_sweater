class Api::V1::SalariesController < ApplicationController
  def index
    destination = params[:destination]
    salaries = SalariesFacade.new.get_tech_salaries(destination)
    render json: SalariesSerializer.new(salaries).serialize_salaries
  end
end