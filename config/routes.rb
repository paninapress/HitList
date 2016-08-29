Rails.application.routes.draw do
	root 'site#index'
    devise_for :users, :path => '', :path_names => {:sign_up => 'signup', :sign_in => 'login'}, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
    get '/dashboard', to: 'site#show', as: 'dashboard'
    get '/dashboard/stars', to: 'site#show', as: 'dashboard_stars'
    get '/dashboard/friends', to: 'site#show', as: 'dashboard_friends'
    resources :friends do
    	resources :logs
 	 end
end