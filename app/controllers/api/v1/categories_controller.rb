class Api::V1::CategoriesController < ApplicationController
  before_action :set_category_service
  before_action :set_category, only: %i[ show update destroy ]

  # GET /api/v1/categories
  def index
    @categories = @category_service.get_categories(query: params[:query])

    render json: @categories
  end

  # GET /api/v1/categories/1
  def show
    render json: @category
  end

  # POST /api/v1/categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/1
  def destroy
    @category.destroy
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
  def category_params
    params.require(:category).permit(:id, :name, :state, :_destroy,
                                     courses_attributes: %i[id name author state _destroy])
  end
end
