module Api
  module V1
    module ResponseHandlerConcern
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

      def exception_response(exception_message)
        {
          status: -1,
          exception: exception_message
        }
      end
    end
  end
end
