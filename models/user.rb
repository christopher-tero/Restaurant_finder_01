class User < ActiveRecord::Base
  has_many :restaurants
  has_many :cities, through: :restaurants  
end
