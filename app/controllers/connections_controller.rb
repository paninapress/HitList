class ConnectionsController < ApplicationController

	def index
		@connections = Connection.all
	end

	def collect
		binding.pry
		Connection.collect_data(request)
		connections = Connection.all
		render :json => connections.as_json
	end

	def create
        new_contact = params.require(:connection).permit(:first_name, :last_name)
        new_contact[:fullname] = params[:connection][:first_name]+ " " + params[:connection][:last_name]
        Connection.create!(new_contact)

        redirect_to "/connections"
	end

    def show
        @connection = Connection.find(params[:id])
    end

    def edit
        @connection = Connection.find(params[:id])
    end

    def update
        contact = Connection.find(params[:id])
        updated_info = params.require(:connection).permit(:first_name, :last_name)
        updated_info[:fullname] = params[:connection][:first_name]+ " " + params[:connection][:last_name]
        contact.update_attributes(updated_info)

        redirect_to connection_path(contact)
    end

end