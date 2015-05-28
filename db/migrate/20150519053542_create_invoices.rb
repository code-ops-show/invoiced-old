class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :number
      t.integer :total
      t.datetime :issue_date
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :item
      t.integer :quantity
      t.integer :unit_price
      t.integer :amount

      t.timestamps null: false
    end
  end
end
