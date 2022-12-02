class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :restaurants
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def self.guest
      find_or_create_by!(name: 'ゲストユーザ', email: 'guest@example.com') do |customer|
        customer.password = SecureRandom.urlsafe_base64
        customer.name = "ゲストユーザ"
      end
  end
  
  
         
end
