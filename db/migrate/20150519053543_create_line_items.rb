class CreateLine_items < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
        t.string   :item
        t.integer  :quantity
        t.datetime :created_at 
        t.datetime :updated_at 
        t.integer  :unit_price
        t.integer  :amount


      t.timestamps null: false
    end
  end
end
