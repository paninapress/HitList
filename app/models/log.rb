class Log < ActiveRecord::Base
  belongs_to :friend, dependent: :destroy
  validates :date, presence: true
  validates :friend_id, presence: true
end
