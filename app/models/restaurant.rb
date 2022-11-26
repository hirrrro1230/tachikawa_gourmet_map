class Restaurant < ApplicationRecord
     has_one_attached :image
     has_many :reviews, dependent: :destroy
     belongs_to :genre
     belongs_to :customer
     
     def avg_score
          restaurant.reviews.overall.average(:review_id).round(1)
     end
    
     def avg_score_percentage
         restaurant.reviews.overall.average(:review_id).round(1).to_f*100/5
     end
     
     
end
