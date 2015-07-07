class RemoveReferencesFromInvoice < ActiveRecord::Migration
  def change
    remove_reference(:invoices, :user, index: true, foreign_key: true)
  end
end
