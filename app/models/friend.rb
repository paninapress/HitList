class Friend < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: {maximum: 50}
  validates :category, presence: true
  validates :user_id, presence: true
end
