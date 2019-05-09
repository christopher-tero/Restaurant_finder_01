require 'pry'
#note to us we have a global variable "$location" ***caution***
#/// Intro ///

def intro
  puts "\n\n".white_on_blue
  print "Welcome to Restaurant Sleuth! Please enter city.".center(85).white_on_blue
  puts "\n\n".white_on_blue
end

def available_cities
  our_cities = Restaurants.all.map do |restaurant|
    restaurant.location.downcase
  end
  our_cities.uniq
end

def city_selector
  $location = gets.chomp.downcase
  # binding.pry
  if available_cities.include?($location)
    puts "\n".white_on_green
    print "Thank you!".center(85).white_on_green
    puts "\n".white_on_green
  else
    puts "Sorry we are not available in your area yet, please vist us at a later time!".center(85).red
    exit
  end
end

def user_list
  User.all.map do |user|
    user.name.downcase
  end
end

# /// Select user: ///

def select_user
  puts "\n\n".white_on_blue
  print "Please enter your name, type 'new user', or exit.".center(85).white_on_blue
  puts "\n\n".white_on_blue
  name = gets.chomp.capitalize
  puts ""
  #binding.pry
  if User.exists?(name: name)
    puts "\n".white_on_magenta
    print "Hello #{name}! How can we help you today?".center(85).white_on_magenta
    puts "\n".white_on_magenta
    #main_menu
  elsif name.downcase == "new user"
    new_user
  elsif name.downcase == "exit"
    exit
  else
    puts "\n".center(85).white_on_red
    print "Please enter a valid selection".center(85).white_on_red
    puts "\n".center(85).white_on_red
    select_user
  end
end

def new_user
    puts "Welcome to our app! Please enter your name:".cyan
    name = gets.chomp.capitalize
    puts ""
    if User.exists?(name: name)
      puts "Sorry! This User name is already taken. Please try again"
      new_user
    else
      puts "\nHello #{name}!"
      User.create(name: name)
    end
end

def main_menu
  puts "\n"
  puts "Please select a number option from the menu below:".center(85).green
  puts "\n"
  puts "1 - Top 10 rated restaurants".center(85).green
  puts "2 - Select a cuisine        ".center(85).green
  puts "3 - Select a price bracket  ".center(85).green
  puts "4 - Select a rating bracket ".center(85).green
  puts "5 - Completely Random       ".center(85).green
  #puts "5 - My favorites".green
  #puts "6 - My blacklist".green
  puts "exit".center(85).green
  puts "\n"
  selection = gets.chomp
  case selection.to_i
  when 1
    top_10
  when 2
    cuisine
  when 3
    price
  when 4
    rating
  when 5
    city_restaurants
  when exit
    exit
  else
    puts "Please enter a valid selection".red
    main_menu
  end
end

def top_restaurant_name
  Restaurants.all.sort_by do |restaurant|
    restaurant.rating
  end
end

def top_10
  puts "\n\n".white_on_blue
  puts "\n"
  puts "You selected top 10 restaurants".center(85).white_on_magenta
  puts "\n"

  best_rest_name = top_restaurant_name.map do |restaurant|
    if restaurant.location.downcase == $location
      restaurant.name
    end
  end
  puts best_rest_name.compact.last(10)
  puts "\n"
  puts "\n\n".white_on_blue

end


def cuisine
  puts "You selected cuisine; please select one of the following numbers:".center(85).green
  puts "1 - American".center(85).green
  puts "2 - Mexican ".center(85).green
  puts "3 - Japanese".center(85).green
  puts "4 - Italian ".center(85).green
  cuisine_choice = gets.chomp.to_i
  if cuisine_choice == 1
    cuisine_selection = "American"
  elsif cuisine_choice == 2
    cuisine_selection = "Mexican"
  elsif cuisine_choice == 3
    cuisine_selection = "Japanese"
  elsif cuisine_choice == 4
    cuisine_selection = "Italian"
  end
  cuisine_selection
  cuisine_random = Restaurants.all.select do |restaurant|
    restaurant.name if restaurant.cuisine == cuisine_selection
  end ##### This iterator should work for all below cases #####

  rando_cuisine = cuisine_random.sample
  case cuisine_choice.to_i
    when 1
      puts "Random American restaurant: ".center(85).cyan
      puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
      # Add a save function
    when 2
      puts "Random Mexican restaurant: ".center(85).cyan
      puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
      # Add a save function
    when 3
      puts "Random Japanese restaurant: ".center(85).cyan
      puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
      # Add a save function
    when 4
      puts "Random Italian restaurant: ".center(85).cyan
      puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
    else
      puts "\n".center(85).white_on_red
      print "Please enter a valid selection".center(85).white_on_red
      puts "\n".center(85).white_on_red
      cuisine
  end
end

### Tested and working w/o db ###
def price
  puts "\n".white_on_magenta
  print "You selected price; please select your price bracket:".center(85).white_on_magenta
  puts "\n".white_on_magenta
  puts "1 - Budget".center(85).magenta
  puts "2 - Mid-level".center(85).magenta
  puts "3 - Extravavant".center(85).magenta
  price_range = gets.chomp
  price_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.price.length == price_range.to_i
  end
  restaurant_selection = price_random.sample
  case price_range
  when "1"
      print "You selected budget restaurants:".center(85).magenta
      puts "\n\n"
      puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(85).cyan_on_red
      puts "\n"
    when "2"
      print "You selected moderately priced restaurants:".center(85).magenta
      puts "\n\n"
      puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(85).cyan_on_red
      puts "\n"
    when "3"
      print "You selected expensive restaurants:".center(85).magenta
      puts "\n\n"
      puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(85).cyan_on_red
      puts "\n"
    else
      puts "\n".white_on_red
      print "Please enter a valid price range:".center(85).white_on_red
      puts "\n".white_on_red
      price
  end
end

def rating ### Working for selection, but need to return string instead of item ###
  puts "You selected rating; please select 3, 4, or 5 stars"
  rating_selection = gets.chomp
  stars_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.rating.to_i == rating_selection.to_i
  end
  #binding.pry
  case rating_selection
    when "3"
      puts "Three star restaurant:"
      rando = stars_random.sample
      puts "name: #{rando.name}, price:#{rando.price}"
      # Add a save function
    when "4"
      puts "Four star restaurant:"
      rando = stars_random.sample
      puts "name: #{rando.name}, price:#{rando.price}"
      # Add a save function
    when "5"
      puts "Five star restaurant:"
      rando = stars_random.sample
      puts "name: #{rando.name}, price:#{rando.price}"
      # Add a save function
    else
      "Please enter a valid input"
      rating
  end
end

def favorites
  puts "You selected favorites; your favorite restaurants are:"
end

def city_restaurants
  rando = Restaurants.all.select do |restaurant|
    restaurant.location.downcase == $location
  end
  city_rando = rando.sample
  puts "name: #{city_rando.name}, price: #{city_rando.price}, rating: #{city_rando.rating}"
end

def end_of_method
  puts
end


### Optional additions:

# Option to add a restaurant to the list
