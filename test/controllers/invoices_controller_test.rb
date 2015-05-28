require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  test "should get index page" do 
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
    assert_includes(assigns(:invoices), invoices(:invoice_one))
  end
end
