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
end
