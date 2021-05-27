class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :owner_id
      t.string :image
      t.integer :burritos_count

      t.timestamps
    end
  end
end
