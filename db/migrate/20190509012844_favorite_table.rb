class FavoriteTable < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.text :name
      t.text :location
      t.text :price
      t.text :rating
      t.text :cuisine
      t.references :city_rest
      t.references :user
    end
  end
end
