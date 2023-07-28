class Api::V1::CoursesController < Api::V1::BaseController
  before_action :set_course_service
  before_action :set_course, only: %i[ show update destroy ]

  # GET /api/v1/courses
  def index
    @courses = @course_service.get_courses(query: params[:query])

    if @courses.nil?
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    else
      render json: success_response(@courses)
    end
  end

  # GET /api/v1/courses/1
  def show
    if @course.present?
      render json: success_response(@course)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  # POST /api/v1/courses
  def create
    status, @course, errors = @course_service.create_course(course_create_params)

    if status
      render json: success_response(@course), status: :created
    else
      render json: error_response(I18n.t('something_went_wrong'), errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/courses/1
  def update
    status, @course, errors = @course_service.update_course(course_update_params)

    if status
      render json: success_response(@course)
    else
      render json: error_response(I18n.t('something_went_wrong'), errors), status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/courses/1
  def destroy
    status = @course_service.destroy_course

    if status
      render json: success_response(@course)
    else
      render json: error_response(I18n.t('something_went_wrong')), status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = @course_service.get_course_by_id(params[:id])
  end

  def set_course_service
    @course_service = ::V1::CourseService.new
  end

  # Only allow a list of trusted parameters through.
  def course_create_params
    params.require(:course).permit(%i[name author state category_id])
  end

  def course_update_params
    params.require(:course).permit(%i[id name author state category_id])
  end
end
