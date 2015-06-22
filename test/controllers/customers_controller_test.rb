require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:user_one)
    sign_in @user
    @customer = customers(:customer_one)
    @invoice = invoices(:invoice_one)
    @line_items = line_items(:line_item_one)
    @payments = payments(:payment_one)
    @customer.__elasticsearch__.index_document
  end

  test "should get customers index page" do 
    get :index, search_method: "firstname", q: "Yan"
    assert_response :success
    assert_equal "Yanin" , @customer.firstname, "Customer name result is not correct"

  end

  test "Elasticsearch test case phone number" do 
    get :index, search_method: "phone_number", q: "333"
    assert_equal "33333333" , @customer.phone_number, "Customer phone number result is not correct"
  end

  test "Elasticsearch test case email" do 
    get :index, search_method: "email", q: "test"
    assert_equal "test1@test.com" , @customer.email, "Customer email result is not correct"
  end

  test "should get new customer" do
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

  test "should get edit customer page" do
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
