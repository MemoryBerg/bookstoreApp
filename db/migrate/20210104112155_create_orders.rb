class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order, array: true, default: []
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
