class Cart < ApplicationRecord

  # has_many :cart_items, dependent: :destroy
  # has_many :books, through: :cart_items
  # belongs_to :user
  validates :user_id, presence: true
end
