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
		Log.assemble_log(updated_info)
		log.update_attributes(updated_info)
		redirect_to friend_path(friend)
	end
	def destroy
		friend = Friend.find(params[:friend_id])
		Log.destroy(params[:id])
		redirect_to friend_path(friend)
	end
end
