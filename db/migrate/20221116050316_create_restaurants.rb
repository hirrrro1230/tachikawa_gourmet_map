class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|

      t.timestamps
      t.integer :customer_id, foreign_key: true
      t.integer :genre_id, null: false, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :opening_hour, null: false
      t.float :latitude
      t.float :longitude
      
    end
  end
end
