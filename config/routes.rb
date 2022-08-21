Rails.application.routes.draw do
  resources :items, only: [:index] 

  # resources :users, only: [:show] do
  #   resources :items, only: [:index]
  # end

  resources :users do
    resources :items, only: [:index, :show,:create]
  end
end
