Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, format: :json do
    namespace :v1 do
      resources :verticals
      resources :categories
      resources :courses
    end
  end
end
