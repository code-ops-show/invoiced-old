class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :date
      t.string :description
      t.string :payment_meyhod
      t.integer :amount
      t.references :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
