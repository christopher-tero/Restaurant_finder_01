require 'pry'
#note to us we have a global variable "$location" ***caution***
#/// Intro ///

def intro
  puts "Welcome to Restaurant Sleuth! Please enter city.".white_on_blue
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
    puts "Thank you".red
  else
    puts "Sorry we are not available in your area yet, please vist us at a later time!"
    exit
  end
end

def user_list
  User.all.map do |user|
    user.name.downcase
  end
end

#/// Select user: ///

def select_user
  puts "Please enter your name, type 'new user', or exit."
  selection = gets.chomp.downcase
  #binding.pry
  if user_list.include?(selection)
    valid_user = selection
  end
  case selection
  when valid_user
    puts "\nHello #{selection}! How can we help you today?".white_on_magenta
  when "new user"
    new_user
  when "exit"
    exit
  else
    puts "please enter a valid selection\n".red
    select_user
  end
end

def selected_user

end

# def find_user(selection)
#   User.all.find do |person|
#     #binding.pry
#     person.name == selection
#   end
# end

def new_user
    puts "Welcome to our app! Please enter your name:".cyan
    new_name = gets.chomp
    if user_list.include?(new_name)
      puts "Sorry! This User name is already taken. Please try again"
      new_user
    else
      puts "\nHello #{new_name}!"
      User.create(name: new_name)
    end
end


def main_menu
  puts "Please select a number option from the menu below:".green
  puts "1 - Top 10 rated restaurants".green
  puts "2 - Select a cuisine".green
  puts "3 - Select a price bracket".green
  puts "4 - Select a rating bracket".green
  puts "5 - Completely Random".green
  #puts "5 - My favorites".green
  #puts "6 - My blacklist".green
  puts "exit".green
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
  puts "You selected top 10 restaurants"
  best_rest_name = top_restaurant_name.map do |restaurant|
    # binding.pry
    if restaurant.location.downcase == $location
      restaurant.name
    end
  end
  puts best_rest_name.compact.last(10)
end


def cuisine
  puts "You selected cuisine; please select one of the following numbers:"
  puts "1 - American"
  puts "2 - Mexican"
  puts "3 - Japanese"
  puts "4 - Italian"
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
  case cuisine_choice.to_i
  when 1
      puts "Random American restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when 2
      puts "Random Mexican restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when 3
      puts "Random Japanese restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when 4
      puts "Random Italian restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    else
      puts "Please enter a valid selection"
      cuisine
  end
end

### Tested and working w/o db ###
def price
  puts "You selected price; please select your price bracket:"
  puts "1 - Budget"
  puts "2 - Mid-level"
  puts "3 - Extravavant"
  price_range = gets.chomp
  price_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.price.length == price_range.to_i
  end
  $restaurant_selection = price_random.sample.name
  case price_range
  when "1"
      puts "You selected budget restaurants"
      puts "#{$restaurant_selection}"
    when "2"
      puts "You selected moderately priced restaurants"
      puts "#{$restaurant_selection}"
    when "3"
      puts "You selected expensive restaurants"
      puts "#{$restaurant_selection}"
    else
      puts "Please enter a valid price range:"
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
      puts "#{stars_random.sample.name}"
      # Add a save function
    when "4"
      puts "Four star restaurant:"
      puts "#{stars_random.sample.name}"
      # Add a save function
    when "5"
      puts "Five star restaurant:"
      puts "#{stars_random.sample.name}"
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
  puts rando.sample.name
end


### Optional additions:

# Option to add a restaurant to the list
