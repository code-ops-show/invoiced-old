class AddInvoiceToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :invoice, index: true, foreign_key: true
  end
end
