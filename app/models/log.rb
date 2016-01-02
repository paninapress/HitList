class Log < ActiveRecord::Base
  belongs_to :friend, dependent: :destroy
end
