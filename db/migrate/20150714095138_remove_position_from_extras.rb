class RemovePositionFromExtras < ActiveRecord::Migration
  def change
    remove_column :extras, :position, :integer
  end
end
