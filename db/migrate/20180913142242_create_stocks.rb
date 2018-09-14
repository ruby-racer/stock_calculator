class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :name
      t.monetize :unit_price
      t.integer :interest
      t.integer :duration
      t.belongs_to :user
      t.timestamps
    end
  end
end
