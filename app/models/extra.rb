class Extra < ActiveRecord::Base
  include RankedModel
  belongs_to :invoice, touch: true
  ranks :row_order
end
