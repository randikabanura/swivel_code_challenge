module V1
  class CourseService

    attr_accessor :course

    def initialize(**args)
      @course = course.find(args[:course_id]) if args[:course_id].present?
    end

    def get_course
      course
    end

    def get_course_by_id(id)
      @course ||= course.find(id)
    end

    def get_courses(**args)
      Course.all
    end
  end
end

