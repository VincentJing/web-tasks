class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts, dependent: :destroy
end
