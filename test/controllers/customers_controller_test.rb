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
    assert_response :success
  end
end
