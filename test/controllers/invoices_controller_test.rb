require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:invoice_one)
    @invoice_2 = invoices(:invoice_two)
  end

  test "should get index page" do 
    get :index

    assert_response :success
    assert_not_nil assigns(:invoices)
    assert_includes(assigns(:invoices), @invoice)
  end

  test "should get new" do
    get :new

    assert_response :success
    assert_not_nil @invoice.number,"invoice number not found"
    assert_equal "001" , @invoice.number,"The invoice number is not correct"
  end

  test "should create invoice" do
    post(:create, invoice: { number: "001" })

    assert_response :success
    assert_not_nil Invoice.find_by(number: "001")
  end

  test "should show invoice" do
    get :show, id: @invoice.id

    assert_response :success, "invoice not found"
  end
  test "should get edit page" do
    get :edit, id: @invoice.id

    assert_response :success, "invoice not found"
  end 

  test "should update invoice" do
    patch :update, id: @invoice.id, invoice: { number: @invoice.number, 
                                               total: @invoice.total,
                                               issue_date: @invoice.issue_date,
                                               due_date: @invoice.due_date }

    assert_redirected_to invoices_path, "not going to index page after updated"
  end

  test "should destroy invoices" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice.id
    end
 
    assert_redirected_to invoices_path
  end
end
