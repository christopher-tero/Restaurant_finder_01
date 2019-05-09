require "pry"
require 'colored'
require "sinatra/activerecord"
require "require_all"
require_all "./lib"
require_all "./models"

ActiveRecord::Base.logger = nil


ActiveRecord::Base.establish_connection({
  adapter: "sqlite3",
  database: "./db/restaurant_list.db"
  })


main
