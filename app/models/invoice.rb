class Invoice < ActiveRecord::Base
  validates :number,
            presence: true,
            uniqueness: true

# invoice = invoice.new
# invoice.number = ""
# invoice.issue_date = ""
# nvoice.due_date = ""
# invoice.total = ""

end

