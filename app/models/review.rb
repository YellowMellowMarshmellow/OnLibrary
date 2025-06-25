class Review < ApplicationRecord
  validates :book, :rating, :user, :rental, presence: true
  belongs_to :book, :rental, :user
end
