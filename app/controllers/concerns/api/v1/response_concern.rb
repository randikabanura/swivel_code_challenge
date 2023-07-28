module Api
  module V1
    module ResponseConcern
      extend ActiveSupport::Concern

      def error_response(error_message)
        {
          status: 0,
          error: error_message
        }
      end

      def success_response(success_message)
        {
          status: 1,
          message: success_message
        }
      end
    end
  end
end
