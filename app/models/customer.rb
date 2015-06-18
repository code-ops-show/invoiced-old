class Customer < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Customers::Indexing
  include Customers::Searching

  belongs_to :user
  has_many :invoices, dependent: :destroy

end
