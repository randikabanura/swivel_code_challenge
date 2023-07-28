class ApplicationController < ActionController::API

  def hello_world
    render json: { status: 1, message: 'Let\'s go. We are alive' }, status: :ok
  end

  def not_found_method
    render json: { status: 0, message: 'Route not found' }, status: :not_found
  end

  private

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: '{"status": 0, "message":"401 Unauthorized"}'}
  end
end
