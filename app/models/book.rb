class Book < ApplicationRecord
  has_one_attached :photo
  validates :title, :author, :categories, :description, presence: true
  belongs_to :user
  has_many :reviews
  has_many :rentals, dependent: :destroy
end
