class Invoice < ActiveRecord::Base

  validates :number,
            presence: true,
            uniqueness: true

  has_many :line_items, :dependent => :destroy
  accepts_nested_attributes_for :line_items
end

