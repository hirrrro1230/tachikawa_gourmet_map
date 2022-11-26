class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.timestamps
      t.integer :restaurant_id, null: false, foreign_key: true
      t.integer :customer_id, null: false, foreign_key: true
      t.integer :overall, null: false, default: 0
      t.text :coment
      
    end
  end
end
