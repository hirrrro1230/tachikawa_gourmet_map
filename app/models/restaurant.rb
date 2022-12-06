class Restaurant < ApplicationRecord
     has_one_attached :image
     geocoded_by :address
     after_validation :geocode
     has_many :reviews, dependent: :destroy
     belongs_to :genre
     belongs_to :customer
     has_many :favorites, dependent: :destroy
     
     def avg_score
          restaurant.reviews.overall.average(:review_id).round(1)
     end
    
     def avg_score_percentage
         restaurant.reviews.overall.average(:review_id).round(1).to_f*100/5
     end
     
     def self.looks(search, word)
         if search == "perfect_match"
           @restaurant = Restaurant.where("name LIKE?","#{word}").or(Restaurant.where"address LIKE?","#{word}")
         elsif search == "forward_match"
           @restaurant = Restaurant.where("name LIKE?","#{word}%").or(Restaurant.where"address LIKE?","#{word}")
         elsif search == "backward_match"
           @restaurant = Restaurant.where("name LIKE?","%#{word}").or(Restaurant.where"address LIKE?","%#{word}")
         elsif search == "partial_match"
           @restaurant = Restaurant.where("name LIKE?","%#{word}%").or(Restaurant.where"address LIKE?","%#{word}%")
         else
           @restaurant = Restaurant.all
         end
     end
     
     
     
     #def self.looks(search, word)
         #if search == "perfect_match"
           #@restaurant = Restaurant.where("address LIKE?","#{word}")
         #elsif search == "forward_match"
           #@restaurant = Restaurant.where("address LIKE?","#{word}%")
         #elsif search == "backward_match"
           #@restaurant = Restaurant.where("address LIKE?","%#{word}")
         #elsif search == "partial_match"
           #@restaurant = Restaurant.where("address LIKE?","%#{word}%")
         #else
           #@restaurant = Restaurant.all
         #end
     #end
     
    def favorited_by?(customer)
        favorites.exists?(customer_id: customer.id)
    end
     
end
