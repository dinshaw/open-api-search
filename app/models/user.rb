class User < ApplicationRecord
  has_secure_password

  has_many :searches

  validates :email, presence: true
  validates :password, presence: true, confirmation: true
end
