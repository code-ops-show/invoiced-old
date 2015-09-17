class ChangePositionToExtra < ActiveRecord::Migration
  def change
    add_column :extras, :row_order, :integer
    remove_column :invoices, :row_order, :integer
  end
end
