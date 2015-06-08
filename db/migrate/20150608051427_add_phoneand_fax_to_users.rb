class AddPhoneandFaxToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :fax, :string
  end
end
