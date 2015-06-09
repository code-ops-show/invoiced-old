class ChangeNamesInPayment < ActiveRecord::Migration
  def change
    rename_column :payments, :payment_meyhod, :payment_method
  end
end
