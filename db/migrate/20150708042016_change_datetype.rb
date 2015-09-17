class ChangeDatetype < ActiveRecord::Migration
  def change
      reversible do |dir|
      change_table :invoices do |t|
        dir.up   { t.change :issue_date, :date }
        dir.down { t.change :issue_date, :datetime }
        dir.up   { t.change :due_date, :date }
        dir.down { t.change :due_date, :datetime }
      end
    end
  end
end
