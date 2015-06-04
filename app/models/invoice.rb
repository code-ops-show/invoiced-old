class Invoice < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :customer

  validates :number,
            presence: true,
            uniqueness: true

  accepts_nested_attributes_for :line_items, 
                                reject_if: lambda { |l| l[:item].blank? || l[:quantity].blank? || l[:unit_price].blank? }, 
                                allow_destroy: true

  after_initialize :invoice_number_incrementation
  after_touch :calculate_total

  def calculate_total
    self.total = line_items.sum(:amount)
    self.save
  end

  def invoice_number_incrementation
    unless number
      last_invoice = Invoice.order(:number).last
      self.number = last_invoice ? last_invoice.number.succ : "001"
    end
  end

end
