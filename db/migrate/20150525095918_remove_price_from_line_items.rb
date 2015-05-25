class RemovePriceFromLineItems < ActiveRecord::Migration
  def change
    remove_column :line_items, :price, :integer
  end
end
