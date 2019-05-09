class User < ActiveRecord::Base
  has_many :favorites
  has_many :city_rest, through: :favorites
end
