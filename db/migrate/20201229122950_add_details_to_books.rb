class AddDetailsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :price, :integer
    add_column :books, :count, :integer
  end
end
