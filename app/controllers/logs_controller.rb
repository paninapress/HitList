class LogsController < ApplicationController
	def new
		@friend = Friend.find(params[:friend_id])
	end
	def create
	end
end
