Rails.application.routes.draw do
  root 'site#index'

  get '/connections', to: 'connections#index'
  post '/connections', to: 'connections#create'
  get 'connections/:id', to: 'connections#show', as: :connection
  get 'connections/:id/edit', to: 'connections#edit', as: :edit_connection
  patch 'connections/:id', to: 'connections#update'
  get '/auth/:provider/callback', to: 'connections#collect'

end
