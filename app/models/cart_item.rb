class CartItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  validates :cart_id, :quantity, presence: true
end
