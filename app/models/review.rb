class Review < ApplicationRecord
  validates :book, :rating, :user, :rental, presence: true
  belongs_to :book
  belongs_to :rental
  belongs_to :user
end
