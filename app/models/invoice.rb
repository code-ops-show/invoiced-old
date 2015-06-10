class Invoice < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :customer, touch: true

  validates :number,
            presence: true,
            uniqueness: true

  accepts_nested_attributes_for :line_items, 
                                reject_if: lambda { |l| l[:item].blank? || l[:quantity].blank? || l[:unit_price].blank? }, 
                                allow_destroy: true
  accepts_nested_attributes_for :payments, 
                                reject_if: lambda { |l| l[:"date(1i)"].blank? || l[:"date(2i)"].blank? || l[:"date(3i)"].blank? || l[:description].blank? || l[:payment_method].blank? || l[:amount].blank? }, 
                                allow_destroy: true

  after_initialize :invoice_number_incrementation
  after_touch :calculate_total, :calculate_total_payment, :calculate_balance

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

  def calculate_total_payment
    self.total_paid = payments.sum(:amount)
    self.save
  end

  def calculate_balance
    self.balance = ((self.total + (self.total * 0.07)) - self.total_paid)
    self.save
  end

end
