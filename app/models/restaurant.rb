class Restaurant < ApplicationRecord
     has_one_attached :image
     geocoded_by :address
     after_validation :geocode
     has_many :reviews, dependent: :destroy
     belongs_to :genre
     belongs_to :customer
     
     def avg_score
          restaurant.reviews.overall.average(:review_id).round(1)
     end
    
     def avg_score_percentage
         restaurant.reviews.overall.average(:review_id).round(1).to_f*100/5
     end
     
     def self.looks(search, word)
         if search == "perfect_match"
           @restaurant = Restaurant.where("title LIKE?","#{word}")
         elsif search == "forward_match"
           @restaurant = Restaurant.where("title LIKE?","#{word}%")
         elsif search == "backward_match"
           @restaurant = Restaurant.where("title LIKE?","%#{word}")
         elsif search == "partial_match"
           @restaurant = Restaurant.where("title LIKE?","%#{word}%")
         else
           @restaurant = Restaurant.all
         end
     end
     
end
