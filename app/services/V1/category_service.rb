module V1
  class CategoryService

    attr_accessor :category

    def initialize(**args)
      @category = Category.find(args[:category_id]) if args[:category_id].present?
    end

    def get_category
      category
    end

    def get_category_by_id(id)
      @category ||= Category.find(id)
    end

    def get_categories(**args)
      Category.all
    end
  end
end

