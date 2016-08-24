Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  root 'site#index'
  get '/dashboard', to: 'site#show', as: 'dashboard'
  resources :friends do
    resources :logs
  end
end