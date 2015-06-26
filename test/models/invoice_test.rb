require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  setup do
    @customer = customers(:customer_one)
    @invoice = invoices(:invoice_one)
    @line_items = line_items(:line_item_one)
    @payment = payments(:payment_one)
  end
  test "calculate_total" do 
    assert_equal(200, @invoice.total)
  end

  test "calculate_total_payment" do
    @invoice.calculate_total_payment    
    assert_equal(100, @invoice.total_paid)
  end

  test "calculate_balance" do
    @invoice.calculate_total_payment
    @invoice.calculate_balance
    assert_equal(114, @invoice.balance)
  end
end
