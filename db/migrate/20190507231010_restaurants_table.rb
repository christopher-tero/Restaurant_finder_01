class RestaurantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.text :name
      t.text :location
      t.text :cuisine
      t.text :price
      t.text :rating
    end
  end
end
