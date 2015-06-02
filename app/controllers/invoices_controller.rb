class InvoicesController < ApplicationController
before_action :authenticate_user!
  def index
     @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new

    @invoice = Invoice.new  

    4.times { @line_items = @invoice.line_items.build }
  
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, :notice => "Your invoice was saved"
    else
      render "new"
    end
 
  end

  def update

    @invoice = Invoice.find(params[:id])


    if @invoice.update_attributes(invoice_params)
      redirect_to invoices_path, :notice => "Your invoice has been updated."
    else
      render "edit"
    end

  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, :notice => "Your invoice has been deleted."
  end

 private
    def invoice_params
      params.require(:invoice).permit(:number, :issue_date, :due_date, :total, 
                                      line_items_attributes: [:id, :item, :quantity, :unit_price, :amount, :invoice_id])
    end  

end

