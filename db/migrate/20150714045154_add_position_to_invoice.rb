class AddPositionToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :row_order, :integer
  end
end
