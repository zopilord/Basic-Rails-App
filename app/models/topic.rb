class Topic < ActiveRecord::Base
	scope :visible_to, lambda { |user| user ? scoped : where(public: true)}
  attr_accessible :description, :name, :public
  has_many :posts, dependent: :destroy
end
