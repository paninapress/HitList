class LogsController < ApplicationController
	def new
		@friend = Friend.find(params[:friend_id])
	end
	def create
		log = Log.new(params.require(:log).permit(:date, :type_of, :rating, :comment))
		log.update_attributes(friend_id: params[:friend_id])
		log.save!
		redirect_to friend_path(log.friend_id)
	end
end
