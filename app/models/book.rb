class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true
  # validates :price, presence: true
  # validates :count, presence: true

end
