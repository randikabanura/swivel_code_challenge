class Api::V1::VerticalsController < ApplicationController
  include Api::V1::ResponseConcern

  before_action :set_vertical_service
  before_action :set_vertical, only: %i[ show update destroy ]

  # GET /api/v1/verticals
  def index
    @verticals = @vertical_service.get_verticals(query: params[:query])

    if @verticals.present?
      render json: success_response(@verticals)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # GET /api/v1/verticals/1
  def show
    if @vertical.present?
      render json: success_response(@vertical)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # POST /api/v1/verticals
  def create
    status, @vertical = @vertical_service.create_vertical(vertical_create_params)

    if status
      render json: success_response(@vertical), status: :created
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/verticals/1
  def update
    status, @vertical = @vertical_service.update_vertical(vertical_update_params)

    if status
      render json: success_response(@vertical)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/verticals/1
  def destroy
    status = @vertical_service.destroy_vertical

    if status
      render json: success_response(@vertical)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
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
  def vertical_create_params
    params.require(:vertical).permit(:name)
  end

  def vertical_update_params
    params.require(:vertical).permit(:id, :name,
      categories_attributes: [:id, :name, :state, :_destroy,
                              courses_attributes: %i[id name author state _destroy]]
    )
  end
end
