require "pry"

require "sinatra/activerecord"
require "require_all"
require_all "./lib"

ActiveRecord::Base.establish_connection({
  adapter: "sqlite3",
  database: "./db/restraunt_db"
  })

#binding.pry
