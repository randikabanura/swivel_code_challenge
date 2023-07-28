module Api
  module V1
    module ErrorHandlerConcern
      extend ActiveSupport::Concern
      include Api::V1::ResponseHandlerConcern

      def self.included(base)
        base.class_eval do
          rescue_from StandardError do |e|
            respond(500, e.to_s)
          end
        end
      end

      private

      def respond(status, message)
        render json: exception_response(message), status: status
      end
    end
  end
end
