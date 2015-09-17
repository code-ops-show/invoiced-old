class Extra < ActiveRecord::Base
  include RankedModel
  belongs_to :invoice, touch: true
  ranks :row_order

  default_scope { rank(:row_order) }
  scope :percentage, -> { where(method: 'percentage') }

  before_save :calculate_amount_after

  def calculate_amount_after(sub_total = nil)
    self.amount = 
      case method
      when 'value'
        extra_value
      when 'percentage'
        (extra_value / 100) * (sub_total || invoice.sub_total)
      end
  end
end
