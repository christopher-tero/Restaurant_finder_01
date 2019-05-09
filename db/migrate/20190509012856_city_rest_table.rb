class CityRestTable < ActiveRecord::Migration[5.2]
  def change
    create_table :city_rests do |t|
      t.text :name
      t.text :location
      t.text :price
      t.text :rating
      t.text :cuisine
    end
  end
end
