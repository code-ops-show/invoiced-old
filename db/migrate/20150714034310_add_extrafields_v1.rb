class AddExtrafieldsV1 < ActiveRecord::Migration
  def change
    add_column :extras, :method, :string
  end
end
