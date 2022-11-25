class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments

  validates_presence_of :title, :description
end
