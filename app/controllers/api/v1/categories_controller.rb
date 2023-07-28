class Api::V1::CategoriesController < ApplicationController
  include Api::V1::ResponseConcern

  before_action :set_category_service
  before_action :set_category, only: %i[ show update destroy ]

  # GET /api/v1/categories
  def index
    @categories = @category_service.get_categories(query: params[:query])

    if @categories.present?
      render json: success_response(@categories)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # GET /api/v1/categories/1
  def show
    if @category.present?
      render json: success_response(@category)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # POST /api/v1/categories
  def create
    status, @category = @category_service.create_category(category_create_params)

    if status
      render json: success_response(@category), status: :created
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/categories/1
  def update
    status, @category = @category_service.update_category(category_update_params)

    if status
      render json: @category
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/1
  def destroy
    status = @category_service.destroy_category

    if status
      render json: success_response(@category)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = @category_service.get_category_by_id(params[:id])
  end

  def set_category_service
    @category_service = ::V1::CategoryService.new
  end

  # Only allow a list of trusted parameters through.
  def category_create_params
    params.require(:category).permit(:name, :state)
  end

  def category_update_params
    params.require(:category).permit(:id, :name, :state, courses_attributes: %i[id name author state _destroy])
  end
end
