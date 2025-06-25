class Rental < ApplicationRecord
  validates :book, :user, :rental_start_date, :rental_end_date, presence: true
  belongs_to :book, :user
end
