class Listing < ApplicationRecord
  belongs_to :user
  has_one :purchase, dependent: :destroy 
  validates :name, :description, :price, :category, :status, presence: true
  validates :price, numericality: { less_than_or_equal_to: 5_000 }
  validates :description, length: { in: 2..500 }
  has_many_attached :images
  enum status: { active: 1, inactive: 2, purchased: 3}
  scope :active, -> { where(status: 1) }
   
  after_initialize :set_default_status

  def set_default_status
    self.status ||= 1
  end

  def find_listing_user_postcode
    
  end

end
