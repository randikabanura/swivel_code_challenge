class Api::V1::VerticalsController < ApplicationController
  before_action :set_vertical, only: %i[ show update destroy ]

  # GET /api/v1/verticals
  def index
    @verticals = Vertical.all

    render json: @verticals
  end

  # GET /api/v1/verticals/1
  def show
    render json: @vertical
  end

  # POST /api/v1/verticals
  def create
    @vertical = Vertical.new(vertical_params)

    if @vertical.save
      render json: @vertical, status: :created, location: @vertical
    else
      render json: @vertical.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/verticals/1
  def update
    if @vertical.update(vertical_params)
      render json: @vertical
    else
      render json: @vertical.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/verticals/1
  def destroy
    @vertical.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vertical
      @vertical = Vertical.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vertical_params
      params.fetch(:vertical, {})
    end
end
