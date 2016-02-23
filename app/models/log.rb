class Log < ActiveRecord::Base
    belongs_to :friend, dependent: :destroy
    validates :date, presence: true
    validates :friend_id, presence: true
    validates :rating, numericality: {    only_integer: true, 
                                        greater_than: 0, 
                                        less_than_or_equal_to: 5 }, if: 'rating.present?'
    
    def self.create_log (friend, data)
        if !data[:date]
            data[:date] = Date.today
        end
        if data[:type_of]
            data[:type_of] = set_log_type(data[:type_of].to_i)
        end
        friend.logs << Log.create(data)
    end

    def self.set_log_type(num)
        log_options = ["Text", "Audio", "Video", "In-Person"]
        return log_options[num - 1]
    end
end