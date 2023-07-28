Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'application#hello_world'

  namespace :api, format: :json do
    namespace :v1 do
      resources :verticals
      resources :categories
      resources :courses
    end
  end

  scope :api, format: :json do
    scope :v1 do
      devise_for :users, path_names: {
        registration: 'signup'
      }, controllers: {
        registrations: 'api/v1/users/registrations'
      }
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications
      end
    end
  end

  # When route is not found it will redirected to not_found_method action
  match '*unmatched', to: 'application#not_found_method', via: :all
end
