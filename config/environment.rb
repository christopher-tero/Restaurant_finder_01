require "pry"

require "sinatra/activerecord"
require "require_all"
require_all "./lib"
require_all "./models"

ActiveRecord::Base.establish_connection({
  adapter: "sqlite3",
  database: "./db/restaurant_list_curated"
  })

binding.pry
