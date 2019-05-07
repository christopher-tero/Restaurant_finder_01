class Restaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.text :user
      t.text :name
      t.text :city
      t.text :cuisine
      t.text :price
      t.text :rating
    end
  end
end
