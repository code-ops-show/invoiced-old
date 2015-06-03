class ChangeCustomerColumn < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.rename :name, :firstname
      t.rename :last_name, :lastname      
end
  end
end
