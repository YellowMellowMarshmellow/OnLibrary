class Rental < ApplicationRecord
  validates :book, :user, :rental_start_date, presence: true
  belongs_to :book
  belongs_to :user
end
