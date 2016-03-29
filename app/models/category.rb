class Category < ActiveRecord::Base
 	validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
end