class Api::V1::CoursesController < ApplicationController
  before_action :set_course_service
  before_action :set_course, only: %i[ show update destroy ]

  # GET /api/v1/courses
  def index
    @courses = @course_service.get_courses(query: params[:query])

    render json: @courses
  end

  # GET /api/v1/courses/1
  def show
    render json: @course
  end

  # POST /api/v1/courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/courses/1
  def destroy
    @course.destroy
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
  def course_params
    params.require(:course).permit(%i[id name author state _destroy])
  end
end
