class ConnectionsController < ApplicationController

def index
end

def collect
	binding.pry
	render :json => {"status" => "done did it"}
end


end