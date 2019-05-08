

require 'pry'

#/// Intro ///

def intro
  puts "Welcome to Restaurants Sleuth! Please enter your name, type 'new user', or exit.".white_on_blue
end

def user_list
  User.all.map do |user|
    user.name
  end
end


#/// Select user: ///

def select_user
  selection = gets.chomp
  #binding.pry
  if user_list.include?(selection)
    valid_user = selection
  end
  case selection
  when valid_user
    puts "Hello #{selection}! How can we help you today?".white_on_magenta
  when "new user"
    new_user
  when "exit"
    exit
  else
    puts "please enter a valid selection".red
    select_user
  end
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
    favorites
  when exit
    exit
  else
    puts "Please enter a valid selection".red
    main_menu
  end
end

def top_10
  puts "You selected top 10 restaurants"
  # Restaurants.all.reduce(1..10) do |x, restaurant|
  #   puts "#{x} - #{restaurant.name}"
  #   x += 1
  # end
end

def cuisine
  puts "You selected cuisine; please select one of the following:"
  puts "American"
  puts "Mexican"
  puts "Japanese"
  puts "Italian"
  cuisine_choice = gets.chomp
  cuisine_random = Restaurants.all.select do |restaurant|
    #binding.pry
    restaurant.name if restaurant.cuisine == cuisine_choice
  end ##### This iterator should work for all below cases #####
  case cuisine_choice
    when "American"
      puts "Random American restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "Mexican"
      puts "Random Mexican restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "Japanese"
      puts "Random Japanese restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "Italian"
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
  puts "$ - Budget"
  puts "$$ - Mid-level"
  puts "$$$ - Extravavant"
  price_range = gets.chomp
  price_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.price == price_range
  end
  $restaurant_selection = price_random.sample.name
  #binding.pry
  case price_range
    when "$"
      puts "You selected budget restaurants"
      puts "#{$restaurant_selection}"
      #puts "#{price_random.sample.name}"
      # Add a save function
    when "$$"
      puts "You selected moderately priced restaurants"
      puts "#{$restaurant_selection}"
      #puts "#{price_random.sample.name}"
      # Add a save function
    when "$$$"
      puts "You selected expensive restaurants"
      puts "#{$restaurant_selection}"
      #puts "#{price_random.sample.name}"
      # Add a save function
    else
      puts "Please enter a valid price range:"
      price
  end

end

def price_budget
end

def price_moderate
end

def price_expensive
end

def rating ### Working for selection, but need to return string instead of item ###
  puts "You selected rating; please select 3, 4, or 5 stars"
  rating_selection = gets.chomp
  stars_random = Restaurants.all.select do |restaurant|
    restaurant if restaurant.rating == rating_selection.to_i
  end
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

def random_selector
end

### Optional additions:

# Option to add a restaurant to the list
