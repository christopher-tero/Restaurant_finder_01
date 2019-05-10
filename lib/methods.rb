require 'pry'
#note to us we have a global variable "$location" and "$name" ***caution***
#/// Intro ///

def intro
  loading_2
  puts `clear`
  puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  puts "".center(236).white_on_green
  print "Welcome to Restaurant Sleuth!".center(118).white_on_green
  puts "".center(236).white_on_green
  sleep 1
  print " Please enter your city:".center(118).white_on_green
  puts "".center(236).white_on_green
  puts "\n\n"
end

def available_cities
  our_cities = CityRest.all.map do |restaurant|
    restaurant.location.downcase
  end
  our_cities.uniq
end

def invalid_selection
  puts "\n\n"
  puts "Please enter a valid selection".center(118).white_on_red
  puts "\n\n"
  sleep 1
end

def city_selector
  $location = gets.chomp.downcase
  puts "\n\n"
  if available_cities.include?($location)
    puts `clear`
    puts "\n"
    if $location == "new york"
      nyc_ascii
    elsif $location == "denver"
      den_ascii_2
    end
    sleep 4
    puts `clear`
    puts "\n\n\n\n\n\n\n\n\n\n"
    print "Get ready for some crazy random restaurants in #{$location.capitalize}!".center(118).green
    puts "\n\n"
    sleep 0.7
  elsif $location == "exit"
      exit_program
  else
    puts "\n\n"
    print "Sorry we are not available in your area yet. Enter another city or exit:".center(118).white_on_red
    puts "\n\n"
    city_selector
  end
end

def select_user
  puts "\n\n"
  print "Please enter your name, type 'new user', or exit.".center(118).blue
  puts "\n\n"
  $name = gets.chomp.capitalize
  puts ""
  sleep 0.5
  if User.exists?(name: $name)
    puts `clear`
    puts "\n\n\n\n\n\n\n\n\n\n"
    print "Hello #{$name}! How can we help you today?".center(118).green
    puts "\n\n"
  elsif $name.downcase == "new user"
    new_user
  elsif $name.downcase == "exit"
    exit_program
  else
    invalid_selection
    select_user
  end
end

def new_user
  puts `clear`
  puts "\n\n\n\n\n\n\n\n\n\n"
  print "Welcome to our app! Please enter your name:".center(118).blue
  puts "\n\n"
  $name = gets.chomp.capitalize
  puts ""
  if User.exists?(name: $name)
    puts "\n\n"
    puts "Sorry! This User name is already taken. Please try again".center(118).white_on_red
    puts "\n\n"
    new_user
  elsif $name == "exit"
    exit_program
  else
    puts `clear`
    puts "\n\n\n\n\n\n\n\n\n\n"
    print "Hello #{$name}!".center(118).green
    puts "\n\n"
    User.create(name: $name)
    sleep 1
  end
end

def main_menu
  puts ""
  puts "Please select a number option from the menu below:".center(118).green
  puts "\n\n"
  puts "1 - Top 10 rated restaurants".center(118).green
  puts "2 - Select a cuisine        ".center(118).green
  puts "3 - Select a price bracket  ".center(118).green
  puts "4 - Select a rating bracket ".center(118).green
  puts "5 - Completely Random       ".center(118).green
  puts "6 - My favorites            ".center(118).green
  puts "exit".center(118).green
  puts "\n\n"
  selection = gets.chomp
  sleep 0.5
  puts `clear`
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
  when "6"
    view_favorites
  when "exit"
    exit_program
  else
    invalid_selection
    main_menu
  end
end

def top_restaurant_name
  CityRest.all.sort_by do |restaurant|
    restaurant.rating
  end
end

def top_10
  puts "\n\n\n\n\n\n\n\n\n\n"
  print "You selected top 10 restaurants for #{$location.capitalize}".center(118).green
  puts "\n\n"
  best_rest_name = top_restaurant_name.select do |restaurant|
    restaurant.location.downcase == $location
  end
  best_rest_name.last(10).each do |restaurant|
    puts "#{restaurant.name}".center(118).magenta
  end
  puts "\n\n"
  end_of_method
end

def cuisine
  puts "\n\n\n\n\n\n\n\n\n\n"
  puts "You selected cuisine; please select one of the following numbers:".center(118).green
  puts "\n\n"
  puts "1 - American".center(118).green
  puts "2 - Mexican ".center(118).green
  puts "3 - Japanese".center(118).green
  puts "4 - Italian ".center(118).green
  puts "\n\n"
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
  cuisine_random = CityRest.all.select do |restaurant|
    restaurant.name if restaurant.cuisine == cuisine_selection
  end
  rando_cuisine = cuisine_random.sample
  case cuisine_choice.to_i
  when 1
    puts "Random American restaurant: ".center(118).green
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(118).red
    add_to_favorite($name, rando_cuisine)
  when 2
    puts "Random Mexican restaurant: ".center(118).green
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(118).red
    add_to_favorite($name, rando_cuisine)
  when 3
    puts "Random Japanese restaurant: ".center(118).green
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(118).red
    add_to_favorite($name, rando_cuisine)
  when 4
    puts "Random Italian restaurant: ".center(118).green
    puts "name: #{rando_cuisine.name}, price: #{rando_cuisine.price}, rating: #{rando_cuisine.rating}".center(118).red
    add_to_favorite($name, rando_cuisine)
  else
    invalid_selection
    cuisine
  end
  end_of_method
end

def price
  puts "\n\n\n\n\n\n\n\n\n\n"
  print "You selected price; please select your price bracket:".center(118).green
  puts "\n\n"
  puts "1 - Budget($)       ".center(118).green
  puts "2 - Mid-level($$)   ".center(118).green
  puts "3 - Extravagant($$$)".center(118).green
  puts ""
  puts "exit   ".center(118).green
  puts "\n\n"
  price_range = gets.chomp
  puts "\n\n"
  price_random = CityRest.all.select do |restaurant|
    restaurant if restaurant.price.length == price_range.to_i
  end
  restaurant_selection = price_random.sample
  case price_range
  when "1"
    puts "You selected Budget($) restaurants".center(118).green
    puts ""
    puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(118).red
    add_to_favorite($name, restaurant_selection)
  when "2"
    puts "You selected Moderately($$) priced restaurants".center(118).green
    puts ""
    puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(118).red
    add_to_favorite($name, restaurant_selection)
  when "3"
    puts "You selected Extravagant($$$) restaurants".center(118).green
    puts ""
    puts "name: #{restaurant_selection.name}, rating: #{restaurant_selection.rating}".center(118).red
    add_to_favorite($name, restaurant_selection)
  when "exit"
    end_of_method
  else
    invalid_selection
    price
  end
  end_of_method
end

def rating
  puts "\n\n\n\n\n\n\n\n\n\n"
  puts "You selected rating; please select 3, 4, or 5 stars!".center(118).green
  puts "\n\n"
  rating_selection = gets.chomp
  puts "\n\n"
  stars_random = CityRest.all.select do |restaurant|
    restaurant if restaurant.rating.to_i == rating_selection.to_i
  end
  #binding.pry
  rando = stars_random.sample
  case rating_selection
  when "3"
    puts "Three star restaurant:".center(118).green
    puts ""
    puts "name: #{rando.name}, price:#{rando.price}".center(118).red
    add_to_favorite($name, rando)
  when "4"
    puts "Four star restaurant:".center(118).green
    puts ""
    puts "name: #{rando.name}, price:#{rando.price}".center(118).red
    add_to_favorite($name, rando)
  when "5"
    puts "Five star restaurant:".center(118).green
    puts ""
    puts "name: #{rando.name}, price:#{rando.price}".center(118).red
    add_to_favorite($name, rando)
  when "exit"
    end_of_method
  else
    invalid_selection
    rating
  end
  end_of_method
end

def city_restaurants
  rando = CityRest.all.select do |restaurant|
    restaurant.location.downcase == $location
  end
  city_rando = rando.sample
  puts "\n\n\n\n\n\n\n\n\n\n"
  puts "Your randomly selected dinning option below!".center(118).green
  puts ""
  puts "name: #{city_rando.name}, price: #{city_rando.price}, rating: #{city_rando.rating}".center(118).red
  add_to_favorite($name, city_rando)
end

def add_to_favorite(name, rando_cuisine)
  puts ""
  puts "Would you like to save to favorites?".center(118).green
  puts ""
  answer = gets.chomp.downcase
  if answer == "yes"
    puts "Adding #{rando_cuisine.name} to your favorite list.".center(118).green
    puts ""
    sleep 2
    user_id = User.find_by(name: $name).id
    list = Favorite.all.select do |restaurant|
      restaurant.user_id == user_id
    end
    if list.any? {|restaurant| restaurant[:city_rest_id] == rando_cuisine.id}
      puts "This is already in your favorites list!".center(118).white_on_red
      view_favorites
    else
      user = User.find_by(name: $name)
      user_id = user.id
      city_rest_id = rando_cuisine.id
      name_id = rando_cuisine.name
      location_id = rando_cuisine.location
      price_id = rando_cuisine.price
      rating_id = rando_cuisine.rating
      cuisine_id = rando_cuisine.cuisine
      Favorite.create(name: name_id, location: location_id, price: price_id, rating: rating_id, cuisine: cuisine_id, city_rest_id: city_rest_id, user_id: user_id)
      puts `clear`
      puts "\n\n\n\n\n"
      puts "#{rando_cuisine.name} has been added to your favorites!".center(118).magenta
      end_of_method
    end
  elsif answer == "no"
    end_of_method
  end
end

def view_favorites
  puts "\n\n\n\n\n\n\n\n\n\n"
  puts "Here are all your favorites:".center(118).green
  puts "\n\n"
  user_id = User.find_by(name: $name).id
  list = Favorite.all.select do |restaurant|
    restaurant.user_id == user_id
  end
  list2 = list.map do |restaurant|
    "name: #{restaurant.name}, location: #{restaurant.location}, cuisine: #{restaurant.cuisine}, price: #{restaurant.price}, rating: #{restaurant.rating}".center(118).magenta
  end
  puts list2.uniq
  #binding.pry
  end_of_method
end

def exit_program
  puts `clear`
  puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  puts "Thank you for using Restaurant Sleuth!".center(118).green
  puts "\n\n"
  puts "See you soon!".center(118).green
  puts "\n\n"
  sleep 2
  puts `clear`
  exit
end

def end_of_method
  puts "\n\n"
  puts "Make another selection or exit?".center(118).green
  puts "\n"
  puts "1 - Make another selection".center(118).green
  puts ""
  puts "exit".center(118).green
  end_select = gets.chomp.downcase
  sleep 1
  puts `clear`
  case end_select
  when "1"
    puts "\n\n\n\n\n\n\n\n\n\n"
    main_menu
  when "exit"
    exit_program
  else
    invalid_selection
    end_of_method
  end
end
