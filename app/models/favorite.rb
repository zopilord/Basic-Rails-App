class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :post
  # attr_accessible :title, :body
end
