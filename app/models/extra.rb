class Extra < ActiveRecord::Base
  include RankedModel
  belongs_to :invoice, :class_name => 'Invoice', touch: true
  ranks :row_order
end
