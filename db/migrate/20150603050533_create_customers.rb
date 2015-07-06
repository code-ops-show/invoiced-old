class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :fax
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
