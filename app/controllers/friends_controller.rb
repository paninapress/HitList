class FriendsController < ApplicationController
	before_filter :authenticate_user!
	def index
		render :json => Friend.where(user_id: current_user)
	end
	def new
		@friend = Friend.new
	end
	def create
		id = current_user.id
		friend = Friend.new(params.require(:friend).permit(:name, :category))
		if friend.update_attributes(user_id: current_user.id)		
			redirect_to friend_path(friend.id)
		else
			flash_errors(friend)
			redirect_to new_friend_path
		end
	end
	def show
		@friend = Friend.find(params[:id])
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
	def destroy
		Friend.destroy(params[:id])
		redirect_to friends_path
	end
	def flash_errors(friend)
		flash[:notice] = "Errors: "
		friend.errors.messages.each do |e|
			flash[:notice] += e.join(" ") + ". "
		end
	end
end
