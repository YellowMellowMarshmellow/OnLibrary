class AddPriceToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :price, :decimal, precision: 8, scale: 2
  end
end
