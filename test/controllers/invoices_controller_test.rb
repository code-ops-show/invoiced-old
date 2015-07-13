require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:user_one)
    sign_in @user
    @customer = customers(:customer_one)
    @invoice = invoices(:invoice_one)
    @line_items = line_items(:line_item_one)
    @payments = payments(:payment_one)
  end

  test "should get new invoice" do
    get :new, customer_id: @customer.id

    assert_response :success
    # assert_not_nil @invoice.number,"invoice number not found"
    # assert_equal "001" , @invoice.number,"The invoice number is not correct"
  end

  test "should create invoice" do
    post(:create, customer_id: @customer.id, invoice: { number: "001" })

    assert_redirected_to customer_path(@customer)
    assert_not_nil Invoice.find_by(number: "001")
  end

  test "should show invoice" do
    get :show, customer_id: @customer.id, id: @invoice.id

    assert_response :success, "invoice not found"
  end

  test "should get edit invoice page" do
    get :edit, customer_id: @customer.id, id: @invoice.id

    assert_response :success, "invoice not found"
  end 

  test "should update invoice" do
    patch :update, customer_id: @customer.id, id: @invoice.id, invoice: { number: @invoice.number, 
                                                                         total: @invoice.total,
                                                                         issue_date: @invoice.issue_date,
                                                                         due_date: @invoice.due_date }

    assert_redirected_to customer_path(@customer), "not going to index page after updated"
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, customer_id: @customer.id, id: @invoice.id
    end
 
    assert_redirected_to customer_path(@customer), "not going back index page after deleted"
  end
end
