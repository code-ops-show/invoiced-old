class Customer < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Customers::Indexing
  include Customers::Searching

  validates :firstname,  length: { minimum: 3 }
  validates :lastname,  length: { minimum: 3 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :phone_number,  length: { maximum: 10 }
  validates :fax,  length: { maximum: 10 }
  
  belongs_to :user
  has_many :invoices, dependent: :destroy
end
