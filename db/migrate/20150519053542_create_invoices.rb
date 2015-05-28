class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.integer :total
      t.datetime :issue_date
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
