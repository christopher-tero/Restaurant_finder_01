class User < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
    end
  end
end
