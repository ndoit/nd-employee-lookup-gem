Rails.application.routes.draw do
  resources :employees do
    collection do
      post '/show', action: :show
      get '/select_example', action: :select_example
    end
  end
end
