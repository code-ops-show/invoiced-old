class AddCustomerRefToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :customer, index: true, foreign_key: true
  end
end
