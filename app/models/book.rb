class Book < ApplicationRecord
  validates :title, :author, :categories, :description, presence: true
  belongs_to :user
  has_many :reviews
  has_many :rentals, dependent: :destroy
  has_one_attached :image
end
