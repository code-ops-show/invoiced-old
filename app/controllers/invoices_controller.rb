class InvoicesController < ApplicationController
  before_action :authenticate_user!
  def index
     @invoices = current_user.invoices
  end

  def show
    @invoice = current_user.invoices.find(params[:id])
  end

  def new

    @invoice = current_user.invoices.new  

    4.times { @line_items = @invoice.line_items.build }
  
  end

  def edit
    @invoice = current_user.invoices.find(params[:id])
  end

  def create
    @invoice = current_user.invoices.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, :notice => "Your invoice was saved"
    else
      render "new"
    end
 
  end

  def update

    @invoice = current_user.invoices.find(params[:id])


    if @invoice.update_attributes(invoice_params)
      redirect_to invoices_path, :notice => "Your invoice has been updated."
    else
      render "edit"
    end

  end

  def destroy
    @invoice = current_user.invoices.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, :notice => "Your invoice has been deleted."
  end

 private
    def invoice_params
      params.require(:invoice).permit(:number, :issue_date, :due_date, :total, :user_id, 
                                      line_items_attributes: [:id, :item, :quantity, :unit_price, :amount, :invoice_id])
    end  

end

