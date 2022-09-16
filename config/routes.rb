Rails.application.routes.draw do
  resources :airports
  resources :flights

  root 'flights#index'

end
