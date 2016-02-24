Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  root 'site#index'
  resources :friends do
    resources :logs
  end
end