class LogsController < ApplicationController
	def new
		@friend = Friend.find(params[:friend_id])
	end
	def create
        friend = Friend.find(params[:friend_id])
        log_data = params.require(:log).permit(:date, :type_of, :rating, :comment)
        Log.create_log(friend, log_data)
		redirect_to friend_path(friend)
	end
	def edit
		@friend = Friend.find(params[:friend_id])
		@log = Log.find(params[:id])
	end
	def update
		friend = Friend.find(params[:friend_id])
		log = Log.find(params[:id])
		updated_info = params.require(:log).permit(:date, :type_of, :rating, :comment)
		if updated_info[:type_of]
            updated_info[:type_of] = Log.set_log_type(updated_info[:type_of].to_i)
        end
		log.update_attributes(updated_info)
		redirect_to friend_path(friend)
	end
end
