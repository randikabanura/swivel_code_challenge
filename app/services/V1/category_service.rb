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
      query = args[:query] || '*'
      Category.search(query).results
    rescue StandardError => e
      []
    end

    def create_category(category_params)
      @category = Category.new(category_params)
      if @category.save!
        [true, @category]
      else
        [false, nil]
      end
    end

    def update_category(category_params)
      if @category.update(category_params)
        [true, @category]
      else
        [false, nil]
      end
    end

    def destroy_category
      @category.destroy
    end
  end
end

