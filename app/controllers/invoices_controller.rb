class InvoicesController < ApplicationController

  def index
     @invoices = Invoice.all
  end

  def show
    @invoices = Invoice.find(params[:id])
  end

  def new
    # @invoices = Invoice.new

  end

  def edit

  end

  def create
 
  end

  def update
  
  end

  def destroy
 
  end
end
