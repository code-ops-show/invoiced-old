class InvoicesController < ApplicationController
  def index
      @invoice = Invoice.all
      respond_to do |format|
        format.html # show.html.erb      
  end
  def show
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
  end
  def create
      @invoice = Invoice.new(invoice_params)
     
      @invoice.save
      redirect_to @invoice
end
end
