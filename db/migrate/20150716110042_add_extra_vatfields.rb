class AddExtraVatfields < ActiveRecord::Migration
  def change
    add_column :extras, :extra_vat, :decimal
  end
end
