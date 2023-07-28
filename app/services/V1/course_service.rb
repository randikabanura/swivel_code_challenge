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
      query = args[:query] || '*'
      Course.search(query).results
    rescue StandardError => e
      []
    end

    def create_course(course_params)
      @course = Course.new(course_params)
      if @course.save!
        [true, @course]
      else
        [false, nil]
      end
    end

    def update_course(course_params)
      if @course.update(course_params)
        [true, @course]
      else
        [false, nil]
      end
    end

    def destroy_course
      @course.destroy
    end
  end
end

