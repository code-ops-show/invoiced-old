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
    @invoice = current_user.invoices.where(id: params[:id]).first 

  end

  def new
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.build

    4.times { @line_items = @invoice.line_items.build }
  
  end

  def edit
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first 
  end

  def create
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.build(invoice_params)
    if @invoice.save
      redirect_to invoices_path, :notice => "Your invoice was saved"
    else
      render "new"
    end
 
  end

  def update
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first 

    if @invoice.update_attributes(invoice_params)
      redirect_to invoices_path, :notice => "Your invoice has been updated."
    else
      render "edit"
    end

  end

  def destroy
    @customer = current_user.customers.where(id: params[:customer_id]).first
    @invoice = @customer.invoices.where(id: params[:id]).first 
    if @invoice.destroy
      redirect_to customer_invoices_path(@customer), :notice => "Your invoice has been deleted."
    else
      # handle failed destroy
    end
  end

private
  def invoice_params
    params.require(:invoice).permit(:number, :issue_date, :due_date, :total, :customer_id, 
                                    line_items_attributes: [:id, :item, :quantity, :unit_price, :amount, :invoice_id, :_destroy])
  end

  def scoped_invoices
    if @customer.present?
      @customer.invoices
    else
      current_user.invoices
    end
  end  



end

