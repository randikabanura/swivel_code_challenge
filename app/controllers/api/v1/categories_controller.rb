class Api::V1::CategoriesController < Api::V1::BaseController
  before_action :set_category_service
  before_action :set_category, only: %i[ show update destroy ]

  # GET /api/v1/categories
  def index
    @categories = @category_service.get_categories(query: params[:query])

    if @categories.nil?
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    else
      render_category_response(@categories)
    end
  end

  # GET /api/v1/categories/1
  def show
    if @category.present?
      render_category_response(@category)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # POST /api/v1/categories
  def create
    status, @category, errors = @category_service.create_category(category_create_params)

    if status
      render_category_response(@category)
    else
      render json: error_response(I18n.t('something_went_wrong'), errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/categories/1
  def update
    status, @category, errors = @category_service.update_category(category_update_params)

    if status
      render_category_response(@category)
    else
      render json: error_response(I18n.t('something_went_wrong'), errors), status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/1
  def destroy
    status = @category_service.destroy_category

    if status
      render_category_response(@category)
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
    params.require(:category).permit(:name, :state, :vertical_id)
  end

  def category_update_params
    params.require(:category).permit(:id, :name, :state, :vertical_id, courses_attributes: %i[id name author state _destroy])
  end

  def render_category_response(category_data)
    response_hash = Api::V1::CategorySerializer.new(category_data).serializable_hash
    render json: success_response(response_hash)
  end
end
