class FriendsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@friends = Friend.all
	end
	def new
		@friend = Friend.new
	end
	def create
		id = current_user.id
		friend = Friend.new(params.require(:friend).permit(:name, :category))
		friend.update_attributes(user_id: current_user.id)
		friend.save!
		redirect_to friend_path(friend.id)
	end
	def show
	end
	def edit
		@friend = Friend.find(params[:id])
	end
	def update
		friend = Friend.find(params[:id])
		updated_info = params.require(:friend).permit(:name, :category)
		friend.update_attributes(updated_info)
		redirect_to friend_path(friend.id)
	end
end
