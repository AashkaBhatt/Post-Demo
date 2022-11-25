class Comment < ApplicationRecord
  acts_as_votable
	belongs_to :user
	belongs_to :post
  validates_presence_of :description
end
