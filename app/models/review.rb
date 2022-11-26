class Review < ApplicationRecord
    belongs_to :customer
    belongs_to :restaurant
    
    validates :overall, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
    
    def getPercent(number) 
        if number.present?
         calPercent = number/5.to_f * 100
         percent = calPercent.round
         return percent.to_s
        else
         return 0
        end
    end
end
