class ApplicationController < ActionController::API

  def hello
    render json: { status: 1, message: 'Let\'s go. We are alive' }, status: :ok
  end

  def not_found_method
    render json: { status: 0, message: 'Route not found' }, status: :not_found
  end
end
