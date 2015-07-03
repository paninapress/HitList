Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'site#index'

  get '/connections', to: 'connections#index'
  post '/connections', to: 'connections#create'
  get 'connections/:id', to: 'connections#show', as: :connection
  get 'connections/:id/edit', to: 'connections#edit', as: :edit_connection
  patch 'connections/:id', to: 'connections#update'
  get '/auth/:provider/callback', to: 'connections#collect'
end

#                   Prefix Verb   URI Pattern                        Controller#Action
#         new_user_session GET    /users/sign_in(.:format)           users/sessions#new
#             user_session POST   /users/sign_in(.:format)           users/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)          users/sessions#destroy
#            user_password POST   /users/password(.:format)          devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)      devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)     devise/passwords#edit
#                          PATCH  /users/password(.:format)          devise/passwords#update
#                          PUT    /users/password(.:format)          devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)            devise/registrations#cancel
#        user_registration POST   /users(.:format)                   devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)           devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)              devise/registrations#edit
#                          PATCH  /users(.:format)                   devise/registrations#update
#                          PUT    /users(.:format)                   devise/registrations#update
#                          DELETE /users(.:format)                   devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)      devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)  devise/confirmations#new
#                          GET    /users/confirmation(.:format)      devise/confirmations#show
#                     root GET    /                                  site#index
#              connections GET    /connections(.:format)             connections#index
#                          POST   /connections(.:format)             connections#create
#               connection GET    /connections/:id(.:format)         connections#show
#          edit_connection GET    /connections/:id/edit(.:format)    connections#edit
#                          PATCH  /connections/:id(.:format)         connections#update
#                          GET    /auth/:provider/callback(.:format) connections#collect
