require 'pry'

#note to us we have a global variable "$location" ***caution***

def intro
  puts "\n".white_on_blue
  print "Welcome to Restaurant Sleuth!".center(85).white_on_blue
  puts "\n".white_on_blue
  sleep 1
  print " Please enter your city:".center(85).white_on_blue
  puts "\n".white_on_blue
end

def available_cities
  our_cities = Restaurants.all.map do |restaurant|
    restaurant.location.downcase
  end
  our_cities.uniq
end

def invalid_selection
  puts "\n".white_on_red
  print "Please enter a valid selection".center(85).red
  puts "\n".white_on_red
  sleep 1
end

def city_selector
  $location = gets.chomp.downcase
  puts "\n"
  if available_cities.include?($location)
    puts "\n".white_on_green
    print "We have selections in your city!".center(85).green
    puts "\n".white_on_green
    sleep 0.7
  else
    if $location == "exit"
      exit
    end
    puts "\n".white_on_red
    print "Sorry we are not available in your area yet. Enter another city or exit:".center(85).red
    puts "\n".white_on_red
    city_selector
  end
end

def user_list
  User.all.map do |user|
    user.name.downcase
  end
end

def select_user
  puts "\n\n".white_on_blue
  print "Please enter your name, type 'new user', or exit.".center(85).white_on_blue
  puts "\n\n".white_on_blue
  name = gets.chomp.capitalize
  puts ""
  sleep 0.5
  if User.exists?(name: name)
    puts "\n".white_on_green
    print "Hello #{name}! How can we help you today?".center(85).green
    puts "\n".white_on_green
  elsif name.downcase == "new user"
    new_user
  elsif name.downcase == "exit"
    exit
  else
    invalid_selection
    select_user
  end
end

def new_user
    puts "Welcome to our app! Please enter your name:".cyan
    name = gets.chomp.capitalize
    puts ""
    if User.exists?(name: name)
      puts "\n".white_on_red
      puts "Sorry! This User name is already taken. Please try again".center(85).red
      puts "\n".white_on_red
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
  puts "exit".center(85).green
  puts "\n"
  selection = gets.chomp
  sleep 0.5
  case selection
  when "1"
    top_10
  when "2"
    cuisine
  when "3"
    price
  when "4"
    rating
  when "5"
    city_restaurants
  when "exit"
    puts "\n".white_on_green
    print "See you soon!".center(85).green
    puts "\n".white_on_green
    puts ""
    sleep 1
    exit
  else
    invalid_selection
    main_menu
  end
end

def top_restaurant_name
  Restaurants.all.sort_by do |restaurant|
    restaurant.rating
  end
end

def top_10
  puts "\n".white_on_green
  print "You selected top 10 restaurants".center(85).green
  puts "\n".white_on_green
  puts ""

  best_rest_name = top_restaurant_name.select do |restaurant|
    restaurant.location.downcase == $location
  end

  best_rest_name.last(10).each do |restaurant|
    puts "#{restaurant.name}".center(85).green
    #binding.pry
  end

  puts "\n"
  end_of_method
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
  when 2
    puts "Random Mexican restaurant: ".center(85).cyan
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
  when 3
    puts "Random Japanese restaurant: ".center(85).cyan
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
  when 4
    puts "Random Italian restaurant: ".center(85).cyan
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(85).cyan
  else
    invalid_selection
    cuisine
  end
  end_of_method
end

def price
  puts "\n".white_on_magenta
  print "You selected price; please select your price bracket:".center(85).white_on_magenta
  puts "\n".white_on_magenta
  puts "1 - Budget".center(85).magenta
  puts "2 - Mid-level".center(85).magenta
  puts "3 - Extravagant".center(85).magenta
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
    invalid_selection
    price
  end
  end_of_method
end

def rating
  puts "You selected rating; please select 3, 4, or 5 stars"
  rating_selection = gets.chomp
  stars_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.rating.to_i == rating_selection.to_i
  end
  case rating_selection
  when "3"
    puts "Three star restaurant:"
    rando = stars_random.sample
    puts "name: #{rando.name}, price:#{rando.price}"
  when "4"
    puts "Four star restaurant:"
    rando = stars_random.sample
    puts "name: #{rando.name}, price:#{rando.price}"
  when "5"
    puts "Five star restaurant:"
    rando = stars_random.sample
    puts "name: #{rando.name}, price:#{rando.price}"
  else
    invalid_selection
    rating
  end
  end_of_method
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
  end_of_method
end

def end_of_method
  puts "\n".white_on_blue
  print "Thank you for using Restaurant Sleuth! Make another selection or exit?".center(85).white_on_blue
  puts "\n".white_on_blue
  puts ""
  puts "1 - Make another selection".center(85).green
  puts "exit".center(85).green
  end_select = gets.chomp.downcase
  case end_select
  when "1"
    main_menu
  when "exit"
    puts "\n".white_on_green
    print "See you soon!".center(85).green
    puts "\n".white_on_green
    puts "\n"
    sleep 1
    exit
  else
    invalid_selection
    end_of_method
  end
end


### Optional additions:

# Add a favorites list
# Option to add a restaurant to the list
