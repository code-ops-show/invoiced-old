require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    # @invoice = invoices(:invoice_one)
    @user = users(:user_one)
    sign_in @user
    @customer = customers(:customer_one)
    @invoice = invoices(:invoice_one)
    @line_items = line_items(:line_item_one)
    @payments = payments(:payment_one)
  end

  test "should get index page" do 
    get :index, search_method: "firstname", q: "Yan"
    @customer.__elasticsearch__.index_document
    assert_response :success
    assert_equal "Yanin" , @customer.firstname,"Customer name result is not correct"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil @customer,"customer not found"
  end

  test "should create customer" do
    post(:create, customer: { firstname: "Memphis" })

    assert_response :redirect
    assert_not_nil Customer.find_by(firstname: "Memphis")
  end

  test "should show customers" do
    get :show, id: @customer.id

    assert_response :success, "customer not found"
  end

  test "should get edit page" do
    get :edit, id: @customer.id

    assert_response :success, "invoice not found"
  end 

  test "should update customer" do
    patch :update, id: @customer.id, customer: { firstname: @customer.firstname, 
                                               lastname: @customer.lastname,
                                               address: @customer.address,
                                               phone_number: @customer.phone_number,
                                               fax: @customer.fax}

    assert_redirected_to customers_path, "not going back index page after updated"
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer.id
    end
 
    assert_redirected_to customers_path, "not going back index page after deleted"
  end
end
