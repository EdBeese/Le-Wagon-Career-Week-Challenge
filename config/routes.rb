Rails.application.routes.draw do
  root to: "pages#home"
  resources :museums, only: [:index, :show]
end
