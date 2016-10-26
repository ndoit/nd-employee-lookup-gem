Rails.application.routes.draw do
  resources :employees do
    collection do
      post '/show', action: :show
    end
  end
end
