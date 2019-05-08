require "pry"
require 'colored'
require "sinatra/activerecord"
require "require_all"
require_all "./lib"
require_all "./models"

ActiveRecord::Base.establish_connection({
  adapter: "sqlite3",
  database: "./db/restaurant_list.db"
  })

main

<<<<<<< HEAD
#binding.pry
=======
# binding.pry
>>>>>>> 8c2ef5078abf4a46365274032efe31353c34a33c
