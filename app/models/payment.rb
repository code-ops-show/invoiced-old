class Payment < ActiveRecord::Base
  belongs_to :invoice, touch: true

end
