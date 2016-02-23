require 'rails_helper'
require 'support/devise'

RSpec.describe LogsController, type: :controller do
	context "GET #new" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            get :new, {friend_id: Friend.last}
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "POST #create" do
        login_user
        it "creates new log" do
            expect{ post :create, {friend_id: Friend.last, log: FactoryGirl.attributes_for(:log)} }.to change(Log,:count).by(1)
        end
        it "redirects to friend's show page" do
            post :create, {friend_id: Friend.last, log: FactoryGirl.attributes_for(:log)}
            expect(response).to redirect_to friend_path(Friend.last)
        end
    end
    context "GET #edit" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            user = FactoryGirl.create(:user)
            log = Log.last
            get :edit, {friend_id: Friend.last, id: log.id}
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "PATCH #update" do
        login_user
        it "calls assemble_log" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id, type_of: "Audio")
            patch :update, friend_id: friend.id, id: log.id, log: { type_of: 1 }
            log.reload
            expect(log.type_of).to eq("Text")
        end
        it "changes attributes of a given log" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id, comment: "Can she fix it?")
            patch :update, friend_id: friend.id, id: log.id, log: { comment: "YES, SHE CAN!" }
            log.reload
            expect(log.comment).to eq("YES, SHE CAN!")
        end
        it "does not change log with invalid attributes" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id, rating: 3)
            patch :update, friend_id: friend.id, id: log.id, log: { rating: 0 }
            log.reload
            expect(log.rating).to eq(3)
        end
        it "redirects to friends#show" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id, comment: "Can she fix it?")
            expect(patch :update, friend_id: friend.id, id: log.id, log: {comment: "YES"}).to redirect_to(friend_path(friend))
        end
    end
    context "DELETE #destroy" do
        login_user
        it "deletes the log" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id)
            expect{delete :destroy, friend_id: friend.id, id: log.id}.to change{friend.logs.count}.by(-1)
        end
        it "redirects to friends#show" do
            friend = FactoryGirl.create(:friend, user_id: subject.current_user.id)
            log = FactoryGirl.create(:log, friend_id: friend.id)
            expect(delete :destroy, friend_id: friend.id, id: log.id).to redirect_to(friend_path(friend))
        end
    end
end