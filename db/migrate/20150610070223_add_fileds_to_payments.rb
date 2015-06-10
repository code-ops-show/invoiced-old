class AddFiledsToPayments < ActiveRecord::Migration
  def change
    add_column :invoices, :total_paid, :integer
    add_column :invoices, :balance, :integer
  end
end
