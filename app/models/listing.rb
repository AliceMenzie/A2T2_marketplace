class Listing < ApplicationRecord
  belongs_to :user
  validates :name, :description, :price, :category, :status, presence: true
  validates :price, numericality: {only_integer: true, less_than_or_equal_to: 5_000}
  validates :description, length: {in: 2..500}
end
