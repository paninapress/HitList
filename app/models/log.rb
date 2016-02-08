class Log < ActiveRecord::Base
  belongs_to :friend, dependent: :destroy
  validates :date, presence: true
  validates :friend_id, presence: true
  validates :rating, numericality: {    only_integer: true, 
                                        greater_than: 0, 
                                        less_than_or_equal_to: 5 }, if: 'rating.present?'
end
