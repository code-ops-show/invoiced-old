class AddExtratoinvoice < ActiveRecord::Migration
  def change
     add_reference :extras, :invoice, index: true, foreign_key: true
  end
end
