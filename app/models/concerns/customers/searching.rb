module Customers
  module Searching
    extend ActiveSupport::Concern

    module ClassMethods

      def custom_search(method, query, options)
        __elasticsearch__.search(
          {
            query: build_query(method, query),
            filter: build_filters(options)
          })
      end

      def build_query(method, query)
        if method.present? && query.present?
          { 
            match_phrase_prefix: build_match_query(method, query)
          }
        else
          {
            match_all: {}
          }
        end
      end

      def build_match_query(method, query)
        case method
        when 'firstname' then { firstname: query }
        when 'email' then { email: query }
        when 'phone_number' then { phone_number: query }
        end
      end

      def build_filters(options)
        {
          term: {
             user_id: options[:user_id]
          }
        }
      end
    end
  end
end
