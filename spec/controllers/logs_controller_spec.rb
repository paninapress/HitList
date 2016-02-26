require 'rails_helper'
require 'support/devise'

RSpec.describe LogsController, type: :controller do
	context "render #new" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            render_template :new, {friend_id: Friend.last}
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "POST #create" do
        subject(:friend){ FactoryGirl.create(:friend) }

        it "creates new log" do
            expect{ post :create, {friend_id: friend.id, log: FactoryGirl.attributes_for(:log)} }.to change(Log,:count).by(1)
        end
        it "redirects to friend's show page" do
            post :create, {friend_id: friend.id, log: FactoryGirl.attributes_for(:log)}
            expect(response).to redirect_to friend_path(friend)
        end
    end
    context "GET #edit" do
        it "responds successfully with an HTTP 200 status code" do
            log = FactoryGirl.create(:log)
            get :edit, {friend_id: log.friend_id, id: log.id}
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "PATCH #update" do
        subject(:log){ FactoryGirl.create(:log, type_of: "Audio", comment: "Can she fix it?")}

        it "does not change log with invalid attributes" do
            patch :update, friend_id: log.friend_id, id: log.id, log: { type_of: "something invalid"}
            log.reload
            expect(log.type_of).to eq("Audio")
        end
        it "changes attributes of a given log" do
            patch :update, friend_id: log.friend_id, id: log.id, log: { comment: "YES, SHE CAN!" }
            log.reload
            expect(log.comment).to eq("YES, SHE CAN!")
        end
        it "calls assemble_log" do
            patch :update, friend_id: log.friend_id, id: log.id, log: { type_of: 1 }
            log.reload
            expect(log.type_of).to eq("Text")
        end
        it "redirects to friends#show" do
            expect(patch :update, friend_id: log.friend_id, id: log.id, log:{comment:"YES!"}).to redirect_to(friend_path(log.friend_id))
        end
    end
    context "DELETE #destroy" do
        subject(:log){ FactoryGirl.create(:log) }
        
        it "deletes the log" do
            friend = Friend.find(log.friend_id)
            expect{delete :destroy, friend_id: log.friend_id, id: log.id}.to change{friend.logs.count}.by(-1)
        end
        it "redirects to friends#show" do
            expect(delete :destroy, friend_id: log.friend_id, id: log.id).to redirect_to(friend_path(log.friend_id))
        end
    end
end