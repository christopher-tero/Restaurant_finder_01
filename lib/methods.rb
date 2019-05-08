require 'pry'

#/// Intro ///

def intro
  puts "\n\n"
  puts "\n\nWelcome to our restaurant finder! Please enter your name, type 'new user', or exit.\n".white_on_blue
  puts ""
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
    puts ""
    puts "Hello #{new_name}!"
    User.create(name: new_name)
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
  top_ten = Restaurants.all.map do |restaurant|
    if restaurant.rating.to_f >= 4.5
      restaurant.name
    end
  end

  puts top_ten.take(10)
end

def cuisine
  puts "You selected cuisine; please select one of the following:"
  puts "1 - American"
  puts "2 - Mexican"
  puts "3 - Japanese"
  puts "4 - Italian"
  cuisine_choice = gets.chomp
  case cuisine_choice
  when "1"
    c_choice = "American"
  when "2"
    c_choice = "Mexican"
  when "3"
    c_choice = "Japanese"
  when "4"
    c_choice = "Italian"
  end
  cuisine_random = Restaurants.all.select do |restaurant|
    restaurant.name if restaurant.cuisine == c_choice
  end
  case cuisine_choice
  when "1"
      puts "Random American restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "2"
      puts "Random Mexican restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "3"
      puts "Random Japanese restaurant: "
      puts "#{cuisine_random.sample.name}"
      # Add a save function
    when "4"
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
