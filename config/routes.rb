Rails.application.routes.draw do
  resources :main, only: :index do
  end
  root "main#index"
end
