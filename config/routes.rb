Rails.application.routes.draw do
  post :contact_us, to: "main#contact_us"
  root "main#index"
end
