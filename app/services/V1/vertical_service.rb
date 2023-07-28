module V1
  class VerticalService

    attr_accessor :vertical

    def initialize(**args)
      @vertical = Vertical.find(args[:vertical_id]) if args[:vertical_id].present?
    end

    def get_vertical
      vertical
    end

    def get_vertical_by_id(id)
      @vertical ||= Vertical.find(id)
    end

    def get_verticals(**args)
      query = args[:query] || '*'
      Vertical.search(query).results
    rescue StandardError => e
      nil
    end

    def create_vertical(vertical_params)
      @vertical = Vertical.new(vertical_params)
      if @vertical.save
        [true, @vertical]
      else
        [false, nil, @vertical.errors.full_messages]
      end
    end

    def update_vertical(vertical_params)
      if @vertical.update(vertical_params)
        [true, @vertical]
      else
        [false, nil, @vertical.errors.full_messages]
      end
    end

    def destroy_vertical
      @vertical.destroy
    end
  end
end

