Rails.application.routes.draw do
  root 'site#index'

  get '/connections', to: 'connections#index' 
  get '/auth/:provider/callback', to: 'connections#collect'
end
