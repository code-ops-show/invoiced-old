class Invoice < ActiveRecord::Base
  belongs_to :customer, touch: true
  has_many :line_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :extras, dependent: :destroy
  
  validates :number,
            presence: true,
            uniqueness: true

  accepts_nested_attributes_for :line_items, 
                                reject_if: lambda { |l| l[:item].blank? || l[:quantity].blank? || l[:unit_price].blank? }, 
                                allow_destroy: true
  accepts_nested_attributes_for :payments, 
                                reject_if: lambda { |l| l[:date].blank? || l[:description].blank? || l[:payment_method].blank? || l[:amount].blank? }, 
                                allow_destroy: true
  accepts_nested_attributes_for :extras, reject_if: lambda { |l| l[:name].blank? || l[:prefix].blank? || l[:method].blank? }, 
                                allow_destroy: true

  after_initialize :invoice_number_incrementation, unless: Proc.new { |invoice| invoice.number.present? }
  after_touch :calculate_balance

  before_create :ensure_issue_and_due_date_exists

  def ensure_issue_and_due_date_exists
    if self.issue_date.nil? and self.due_date.nil?
      self.issue_date = Date.today
      self.due_date   = Date.tomorrow
    end
  end

  def calculate_sub_total
    self.sub_total = line_items.sum(:amount)
  end

  def calculate_extras
    extras.percentage.each do |extra|
      extra.calculate_amount_after(sub_total)
      extra.save
    end
  end

  def calculate_total
    calculate_sub_total
    calculate_extras
    temp = 0
    extras.each do |extra|
      case extra.prefix
      when 'discount'
        temp = temp - extra.amount
      when 'cost'
        temp = temp + extra.amount
      end
    end
    self.total = self.sub_total + temp
    self.save
  end

  def invoice_number_incrementation
    last_invoice = Invoice.order(:number).last
    self.number = last_invoice ? last_invoice.number.succ : "001"
  end

  def calculate_total_payment
    self.total_paid = payments.sum(:amount)
  end

  def calculate_balance
    calculate_total
    calculate_total_payment

    self.balance = self.total - self.total_paid
    self.save
  end

  def update_row_order
    @invoice = Invoice.find(invoice_params[:invoice_id])
    @invoice.row_order_position = invoice_params[:row_order_position]
    @invoice.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end
end
