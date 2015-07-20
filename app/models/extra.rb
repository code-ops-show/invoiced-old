class Extra < ActiveRecord::Base
  include RankedModel
  belongs_to :invoice, touch: true
  ranks :row_order

  default_scope { rank(:row_order) }
  before_save :calculate_amount_after
  def calculate_amount_after
    case method
    when 'value'
      self.amount = extra_value
    when 'percentage'
      self.amount = (extra_value / 100) * invoice.total
    end
  end
end
