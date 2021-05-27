class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.float :rating_value
      t.integer :burrito_id
      t.integer :rater_id

      t.timestamps
    end
  end
end
