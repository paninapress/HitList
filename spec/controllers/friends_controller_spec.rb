require 'rails_helper'
require 'support/devise'

RSpec.describe FriendsController, type: :controller do
	context "GET #index" do
        login_user
        before(:each) do
            get :index, format: :json
        end

        it "should have a current_user" do
            expect(subject.current_user).to_not be_nil
        end
        it "responds successfully with an HTTP 200 status code" do
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
        it "renders user's friends to JSON" do
            expect(response.body).to match(subject.current_user.friends.to_json)
        end
        it "only gets current_user's friends"
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
        before(:each) do
            post :create, friend: FactoryGirl.attributes_for(:friend)
        end

        it "creates new friend" do
            expect{ post :create, friend: FactoryGirl.attributes_for(:friend) }.to change(Friend,:count).by(1)
        end
        it "sets user_id to the current_user's id" do
            expect( Friend.last.user_id ).to be( subject.current_user.id )
        end
        it "redirects to the new contact" do
            expect(response).to redirect_to friend_path(Friend.last.id)
        end
        it "flashes notice if it does not save" do
            post :create, friend: FactoryGirl.attributes_for(:friend, name:nil, category: nil)
            expect(flash[:notice]).to eq("Errors: name can't be blank. category can't be blank. ")
        end
        it "renders #new if does not save" do
            expect(post :create, friend: FactoryGirl.attributes_for(:friend, category: nil)).to redirect_to(new_friend_path)
        end
    end
    context "GET #show" do
        login_user
        let(:friend){ FactoryGirl.create(:friend, user_id: subject.current_user.id) }

        it "responds successfully with an HTTP 200 status code" do
            get :show, id: friend.id
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "GET #edit" do
        login_user
        let(:friend){ FactoryGirl.create(:friend, user_id: subject.current_user.id) }
        
        it "responds successfully with an HTTP 200 status code" do
            get :edit, id: friend.id
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "PATCH #update" do
        login_user
        let(:friend){ FactoryGirl.create(:friend, name: "Mom", user_id: subject.current_user.id) }

        it "changes attributes of given friend" do
            patch :update, id: friend.id, friend: {name: "Dad"}
            friend.reload
            expect(friend.name).to eq("Dad")
        end
        it "does not change friend with invalid attributes" do
            patch :update, id: friend.id, friend: {name: nil}
            friend.reload
            expect(friend.name).to eq("Mom")
        end
        it "redirects to friends#show" do
            expect(patch :update, id: friend.id, friend: {name:"Mom"}).to redirect_to friend_path(friend)
        end
    end
    context "DELETE #destroy" do
        login_user
        let(:friend){ FactoryGirl.create(:friend, user_id: subject.current_user.id) }

        it "deletes the friend" do
            id = friend.id
            expect{delete :destroy, id: id}.to change{subject.current_user.friends.count}.by(-1)
        end
        it "redirects to friends#index" do
            expect(delete :destroy, id: friend.id).to redirect_to friends_path
        end
    end
end
