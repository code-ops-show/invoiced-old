class AddExtrafields < ActiveRecord::Migration
  def change
    add_column :extras, :name, :string
    add_column :extras, :amount, :integer
    add_column :extras, :prefix, :string
    add_column :extras, :position, :integer
  end
end
