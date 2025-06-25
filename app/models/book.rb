class Book < ApplicationRecord
  validates :title, :author, :categories, :description, presence: true
  belongs_to :user
  has_many :reviews, :rentals
end
