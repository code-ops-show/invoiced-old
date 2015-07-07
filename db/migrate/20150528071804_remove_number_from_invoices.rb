class RemoveNumberFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :number, :integer
  end
end
