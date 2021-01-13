class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :address
      t.integer :orders
      t.string :role
      t.string :cart, array: true, default: []

      t.timestamps
    end
  end
end
