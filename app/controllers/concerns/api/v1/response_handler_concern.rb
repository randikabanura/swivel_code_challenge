module Api
  module V1
    module ResponseHandlerConcern
      extend ActiveSupport::Concern

      def error_response(error_message, errors = [])
        response = {
          status: 0,
          message: error_message
        }
        response.merge({ errors: errors }) if errors.present?
        response
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
