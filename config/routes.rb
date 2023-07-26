Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'application#hello'

  namespace :api, format: :json do
    namespace :v1 do
      resources :verticals
      resources :categories
      resources :courses
    end
  end

  # When route is not found it will redirected to not_found_method action
  match '*unmatched', to: 'application#not_found_method', via: :all
end
