require "rails_helper"
require 'support/devise'

describe ConnectionsController do
  login_user

  it "should have a current_user" do
    expect(subject).to_not be_nil
  end

  it "should get index" do
    get 'index'
    expect(response).to be_success
  end
end