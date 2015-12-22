require 'rails_helper'
require 'support/devise'

RSpec.describe FriendsController, type: :controller do
	context "GET #index" do
        login_user
        it "should have a current_user" do
            expect(subject.current_user).to_not be_nil
        end

        it "responds successfully with an HTTP 200 status code" do
            get :index
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "GET #new" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            get :new
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "POST #create" do
        login_user
        it "creates new friend" do
            expect{ post :create, friend: FactoryGirl.attributes_for(:friend) }.to change(Friend,:count).by(1)
        end
        it "sets user_id to the current_user's id" do
            current_user = subject.current_user
            post :create, friend: FactoryGirl.attributes_for(:friend)
            expect( Friend.last.user_id ).to be( current_user.id )
        end
        it "redirects to the new contact" do
            post :create, friend: FactoryGirl.attributes_for(:friend)
            expect(response).to redirect_to friend_path(Friend.last.id)
        end
    end
    context "GET #show" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            get :show, id: friend.id
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "GET #edit" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            get :edit, id: friend.id
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "PATCH #update" do
        login_user
        it "changes attributes of given friend" do
            friend = FactoryGirl.create(:friend, name: "Mom", user_id: subject.current_user.id)
            expect(friend.name).to eq("Mom")
            patch :update, id: friend.id, friend: {name: "Dad"}
            friend.reload
            expect(friend.name).to eq("Dad")
        end
    end
    context "DELETE #destroy" do
        login_user
        it "deletes the friend" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            expect{delete :destroy, id: friend.id}.to change(Friend, :count).by(-1)
        end
        it "redirects to friends#index" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            expect(delete :destroy, id: friend.id).to redirect_to friends_path
        end
    end
end
