class Order < ApplicationRecord
  has_many :books
  belongs_to :user
end
