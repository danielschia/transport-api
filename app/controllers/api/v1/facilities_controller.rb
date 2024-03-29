class Api::V1::FacilitiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_facility, only: %i[show update destroy]

  # GET /facilities
  def index
    @facilities = Facility.all

    render json: @facilities
  end

  # GET /facilities/1
  def show
    render json: @facility
  end

  # POST /facilities
  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      render json: @facility, status: :created, location: api_v1_facility_url(@facility)
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /facilities/1
  def update
    if @facility.update(facility_params)
      render json: @facility
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  # DELETE /facilities/1
  def destroy
    @facility.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def facility_params
    params.require(:facility).permit(:cep, :complement, :number, :city, :state, :country, :description, :customer_id)
  end
end
