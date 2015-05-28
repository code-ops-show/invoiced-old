require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "calculate_total" do 
    invoice = invoices(:invoice_one)

    
    assert_equal(200, invoice.total)
  end
end
