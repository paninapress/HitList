class Log < ActiveRecord::Base
    belongs_to :friend
    validates :date, presence: true
    validates :friend_id, presence: true
    validates :rating, numericality: {    only_integer: true, 
                                        greater_than: 0, 
                                        less_than_or_equal_to: 5 }, if: 'rating.present?'
    validates :type_of, inclusion: { in: ["Text", "Audio", "Video", "In-Person"], message: "%{value} is not a valid type", allow_nil: true }

    def self.assemble_log(data)
        if !data[:date] || data[:date] == ""
            data[:date] = Date.today
        end
        if data[:type_of] && data[:type_of].to_i != 0 # "string".to_i returns 0, so we want to leave it
            data[:type_of] = set_log_type(data[:type_of].to_i)
        end
        return data
    end
    def self.create_log (friend, data)
        assemble_log(data)
        friend.logs << Log.create(data)
    end

    def self.set_log_type(num)
        log_options = ["Text", "Audio", "Video", "In-Person", nil]
        return log_options[num - 1]
    end
end