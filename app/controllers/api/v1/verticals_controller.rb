class Api::V1::VerticalsController < ApplicationController
  before_action :set_vertical_service
  before_action :set_vertical, only: %i[ show update destroy ]

  # GET /api/v1/verticals
  def index
    @verticals = @vertical_service.get_verticals

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
    @vertical = @vertical_service.get_vertical_by_id(params[:id])
  end

  def set_vertical_service
    @vertical_service = ::V1::VerticalService.new
  end

    # Only allow a list of trusted parameters through.
    def vertical_params
      params.require(:vertical).permit(
        :name,
        categories_attributes: [ :id, :name, :state, :_destroy,
                                 courses_attributes: %i[id name author state _destroy]]
      )
    end
  end
