class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  has_many :addresses, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :purchases, dependent: :destroy 
  # below is code relating to nested address form 
  accepts_nested_attributes_for :addresses
end
