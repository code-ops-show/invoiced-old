require 'test_helper'

class LineItemTest < ActiveSupport::TestCase

    test "calculate_amount" do 
    lineItem = line_items(:line_item_one)


    
    assert_equal(200, lineItem.calculate_amount)
  end
end
