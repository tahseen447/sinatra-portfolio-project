class User < ActiveRecord::Base
  has_many :grocery_lists
  has_secure_password
end
