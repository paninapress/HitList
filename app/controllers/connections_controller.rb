class ConnectionsController < ApplicationController

	def index
		@connections = Connection.all
	end
    
	def create
        Connection.create!(first_name: params[:contact][:first_name], last_name: params[:contact][:last_name], fullname: params[:contact][:first_name]+ " " + params[:contact][:last_name])
        redirect_to "/connections"
	end

end