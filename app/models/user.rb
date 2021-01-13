class User < ApplicationRecord

  has_many :orders

  validates :email, presence: true, length: { minimum: 10}
end
