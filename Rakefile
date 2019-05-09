require_relative "./config/environment"
require "sinatra/activerecord/rake"
require 'csv'
require 'sqlite3'

desc "Process CSV"
task :process_csv do

  db = SQLite3::Database.new("db/restaurant_list.db")
  db.execute("CREATE TABLE IF NOT EXISTS restaurants (
    id INTEGER PRIMARY KEY,
    name,
    location,
    cuisine,
    price,
    rating
  )")

    csv_text = File.read("restaurants.csv")
    csv =  CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    db.execute("INSERT INTO city_rests (
      name,
      location,
      cuisine,
      price,
      rating
    ) VALUES (?, ?, ?, ?, ?)",
    row["name"],row["location"],row["cuisine"],row["price"],row["rating"]
  )
end
puts "Done!"
end
