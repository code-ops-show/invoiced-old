class Extra < ActiveRecord::Base
  include RankedModel
  belongs_to :invoice, touch: true
  ranks :row_order

  default_scope { rank(:row_order) }
end
