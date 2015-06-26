class Connection < ActiveRecord::Base

	def self.collect_data (info)
		info = info.env["omniauth.auth"]["extra"]["raw_info"]["connections"]["values"]
		info.each do |connection|
			first_name = connection["firstName"]
			last_name = connection["lastName"]
			full_name = first_name + " " + last_name
			Connection.create(first_name: first_name, last_name: last_name, fullname: full_name)
		end
	end

end