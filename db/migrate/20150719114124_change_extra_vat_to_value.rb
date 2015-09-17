class ChangeExtraVatToValue < ActiveRecord::Migration
  def change
    rename_column :extras, :extra_vat, :extra_value
  end
end
