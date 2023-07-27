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
      []
    end
  end
end

