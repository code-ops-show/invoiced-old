class ExtrasController < ApplicationController
  before_action :authenticate_user!


  def update
    @invoice = current_user.invoices.where(id: params[:invoice_id]).first
    # @extra   = @invoice.extras.where(id: params[:extra_id]).first
    if @extra.update_attribute :row_order, params[:extra][:row_order].to_i
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

end
