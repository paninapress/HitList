require "rails_helper"
require 'support/controller_macros'

describe ConnectionsController do
  login_user

  it "should have a current_user" do
  	pending
    # subject.current_user.should_not be_nil
  end

  it "should get index" do
    pending
    # get 'index'
    # response.should be_success
  end
end