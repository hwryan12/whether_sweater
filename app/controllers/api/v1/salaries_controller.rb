class Api::V1::SalariesController < ApplicationController
  def index
    salaries = SalariesFacade.new.get_tech_salaries(params[:destination])
    render json: SalariesSerializer.new(salaries).serialize_salaries
  end
end