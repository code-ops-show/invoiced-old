module Customers
  module Searching
    extend ActiveSupport::Concern

    module ClassMethods

      # def search(method, query)
      #   if method == 'firstname'
      #     dfsfds
      #     # name_search(query)
      #   elsif method == 'email'
      #     # email_search(query)
      #   end
      # end

      def custom_search(method, query)
        __elasticsearch__.search(
          {
            query: {
              match_phrase_prefix: build_match_query(method, query)
            }
          })
      end

      def build_match_query(method, query)
        case method
        when 'firstname' then { firstname: query }
        when 'email' then { email: query }
        when 'phone_number' then { phone_number: query }
        end
      end
    end
  end
end
