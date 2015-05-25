class RemoveNumberFromLineItems < ActiveRecord::Migration
  def change
    remove_column :line_items, :number, :string
  end
end
