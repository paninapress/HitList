Rails.application.routes.draw do
  root 'site#index'

  get '/connections', to: 'connections#index' 
end
