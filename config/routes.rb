Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  root 'site#index'
  get '/friends', to: 'friends#index'
  get '/friends/new', to: 'friends#new'
  post '/friends', to: 'friends#create'
  get '/friends/:id', to: 'friends#show', as: 'friend'
end

#                   Prefix Verb   URI Pattern                       Controller#Action
#         new_user_session GET    /users/sign_in(.:format)          users/sessions#new
#             user_session POST   /users/sign_in(.:format)          users/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)         users/sessions#destroy
#            user_password POST   /users/password(.:format)         devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#                          PATCH  /users/password(.:format)         devise/passwords#update
#                          PUT    /users/password(.:format)         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)           users/registrations#cancel
#        user_registration POST   /users(.:format)                  users/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)          users/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             users/registrations#edit
#                          PATCH  /users(.:format)                  users/registrations#update
#                          PUT    /users(.:format)                  users/registrations#update
#                          DELETE /users(.:format)                  users/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)     devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#                          GET    /users/confirmation(.:format)     devise/confirmations#show
#                     root GET    /                                 site#index