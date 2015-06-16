class Customer < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Customers::Indexing

  belongs_to :user
  has_many :invoices, dependent: :destroy

end
