class AddIsVatToExtras < ActiveRecord::Migration
  def change
    add_column :extras, :is_vat, :boolean
  end
end
