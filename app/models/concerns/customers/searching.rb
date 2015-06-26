module Customers
  module Searching
    extend ActiveSupport::Concern

    module ClassMethods

      def custom_search(method, query, options)
        __elasticsearch__.search(
          {
            query: build_multi_match(method, query),
            filter: build_filters(options)
          })
      end

      def build_match_query(method)
        case method
        when 'firstname' then [ "firstname", "lastname" ]
        when 'email' then [ "email" ]
        when 'phone_number' then [ "phone_number" ]
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
        if method.present? && query.present?  
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




