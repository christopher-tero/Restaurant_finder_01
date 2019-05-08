class CityTable < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.text :name
    end
  end
end
