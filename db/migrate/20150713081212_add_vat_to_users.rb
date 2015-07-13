class AddVatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vat, :decimal, precision: 5, scale: 2
  end
end
