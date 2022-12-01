class Genre < ApplicationRecord
    has_many :restaurants, dependent: :destroy
    validates :name, presence: true
    
    def self.looks(search, word)
        if search == "perfect_match"
          @genre = Genre.where("name LIKE?", "#{word}")
        elsif search == "forward_match"
          @genre = Genre.where("name LIKE?","#{word}%")
        elsif search == "backward_match"
          @genre = Genre.where("name LIKE?","%#{word}")
        elsif search == "partial_match"
          @genre = Genre.where("name LIKE?","%#{word}%")
        else
          @genre = Genre.all
        end
    end
end
