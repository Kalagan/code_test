Rails.application.routes.draw do
  root to: redirect('/leads/new')
  resources :leads, only: [:index, :new, :create]
end
