class AddSubTotalToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :sub_total, :decimal
  end
end
