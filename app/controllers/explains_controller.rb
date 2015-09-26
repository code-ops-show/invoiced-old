class ExplainsController < ApplicationController
  before_action :authenticate_user!
  require 'json'

  def show
    @explain = Customer.explain_search(params[:search_method], params[:q], options, params[:customer_id])
    respond_with @explain
  end


private

    def options
      {
        user_id: current_user.id
      }
    end

end