class InvoicesController < ApplicationController
  before_action :authenticate_user!


  def index
     @customer = current_user.customers.where(id: params[:customer_id]).first
     @invoices = scoped_invoices
  end

  def show
    # eager load
    # @invoice = current_user.invoices.find(params[:id]) 
    # lazy load
    # @invoice = current_user.invoices.where(id: params[:id]).first 
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first 

  end

  def new
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.build
    @line_items = @invoice.line_items.build
    @invoice.extras.build(name: 'VAT', is_vat: true)
  end

  def edit
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first
  end

  def create
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.build(invoice_params)
    if @invoice.save
      redirect_to customer_path(@customer), :notice => "Your invoice was saved"
    else
      render "new"
    end
 
  end

  def update
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first
    if @invoice.update_attributes(invoice_params)
      redirect_to customer_invoice_path(@customer,@invoice), :notice => "Your invoice has been updated."
    else
      render "edit"
    end

  end

  def destroy
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first 
    if @invoice.destroy
      redirect_to customer_path(@customer), :notice => "Your invoice has been deleted."
    else
      # handle failed destroys
    end
  end


private
  def invoice_params
    params.require(:invoice).permit(:number, :issue_date, :due_date, :sub_total, :total, :customer_id, :total_paid, :balance, :row_order_position,
                                    line_items_attributes: [:id, :item, :quantity, :unit_price, :amount, :invoice_id, :_destroy],
                                    payments_attributes: [:id, :date, :description, :payment_method, :amount, :invoice_id, :_destroy],
                                    extras_attributes: [:id, :name, :amount, :prefix, :method, :invoice_id, :row_order, :extra_value, :is_vat ,:_destroy])

  end


  def scoped_invoices
    if @customer.present?
      @customer.invoices
    else
      current_user.invoices
    end
  end  

end
