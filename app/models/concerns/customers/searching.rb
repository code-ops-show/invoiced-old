module Customers
  module Searching
    extend ActiveSupport::Concern

    module ClassMethods

      def custom_search(method, query, options)
        __elasticsearch__.search(
          {
            query: build_multi_match(method, query),
            filter: build_filters(options),
            size: 100
          })
      end

      def explain_search(method, query, options, customer_id)
        query_filters = build_multi_match(method, query)

        __elasticsearch__.client.explain index: Customer.index_name, type: Customer.document_type, id: customer_id,  body: (
          {
            query: query_filters
          })
      end

      def build_match_query(method)
        case method.presence
        when 'firstname' then [ "firstname", "lastname" ]
        when 'email' then [ "email" ]
        when 'phone_number' then [ "phone_number" ]
        else ["firstname", "lastname", "email", "phone_number"]
        end
      end

      def build_filters(options)
        {
          term: {
             user_id: options[:user_id]
          }
        }
      end

      def build_multi_match(method,query)
        if query.present?
          {
            multi_match: {
              query: query,
              type: "phrase_prefix",
              fields: build_match_query(method)
             }
          }
        else
          {
            match_all: {}
          }
        end
      end

    end
  end
end




