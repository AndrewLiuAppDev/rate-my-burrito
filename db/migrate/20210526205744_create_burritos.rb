class CreateBurritos < ActiveRecord::Migration[6.0]
  def change
    create_table :burritos do |t|
      t.string :name
      t.string :tortilla
      t.string :image
      t.integer :restaurant_id
      t.integer :owner_id
      t.float :price
      t.integer :ratings_count

      t.timestamps
    end
  end
end
