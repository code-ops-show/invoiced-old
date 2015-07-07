module Customers
  module Indexing
    extend ActiveSupport::Concern
    included do 
      index_name [Rails.env, 'customers'].join('_')
      mapping do 
        indexes :id, index: :not_analyzed
        indexes :firstname
        indexes :lastname,  type: 'string'
        indexes :address,  type: 'string'
        indexes :phone_number,  type: 'string'
        indexes :fax,  type: 'string'
        indexes :email,  type: 'string'
      end
    end
  end
end