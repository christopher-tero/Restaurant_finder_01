

#saves restaurants to a specific user so that they can call on their favorites

# def list_of_favorite_restaurants(name)
#   Restaurants.all.find do |restaurant|
#     if restaurant.name == name
#       restaurant
#     end
#   end
# end

#show a list of the higest rated restaurants for each category. Arguements will be cuisine, price

#filter out restaurants based on price bracket

#filter out restaurants based on cuisine

#filter out restaurants based on location

# def self.add_to_favorite(name)
#   favorite = Restaurants.all.find do |restaurant|
#     if restaurant.name == name
#       restaurant.name
#     end
#   end
#   User.all << favorite
#   favorite
# end
#
# def User.favorite_restaurants
#   User.all.select do |restaurant|
#     restaurant.name
#   end
# end

# def self.new_user
#   if user_list.include?(selection)
#     puts "Sorry! This User name is already taken. Please try again"
#     select_user #this loops back to the original ask
#   else
#     new_user = User.create(selection)
#   end
#   puts "Welcome #{new_user}!"
# end
#
# def city_selector(selection)
#   Restaurants.all.select do |restaurant|
#     restaurant.location == selection
#   end
# end
