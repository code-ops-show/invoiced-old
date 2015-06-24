class CustomersController < ApplicationController
 before_action :authenticate_user!
  def index
    @customers = Customer.custom_search(params[:search_method], params[:q], options).results
     # @customers = current_user.customers
     # @customers = current_user.customers.search((params[:q].present? ? params[:q] : '*')).records
  end

  def show
    # eager load
    # @invoice = current_user.invoices.find(params[:id]) 

    # lazy load
    @customer = current_user.customers.where(id: params[:id]).first 
    @invoices = @customer.invoices.where(id: params[:id]).first 

  end

  def new

    @customer = current_user.customers.build

  
  end

  def edit
    @customer = current_user.customers.where(id: params[:id]).first 
  end

  def create
    @customer = current_user.customers.build(customer_params)
    if @customer.save
      redirect_to customers_path, :notice => "Your customer information was saved"
    else
      render "new_customer_path"
    end
 
  end

  def update

    @customer = current_user.customers.where(id: params[:id]).first 


    if @customer.update_attributes(customer_params)
      redirect_to customers_path, :notice => "Your customer information has been updated."
    else
      render "edit_customer_path"
    end

  end

  def destroy
    @customer = current_user.customers.where(id: params[:id]).first 
    @customer.destroy
    redirect_to customers_path, :notice => "Your customer information has been deleted."
  end

 private
    def customer_params
      params.require(:customer).permit(:firstname, :lastname, :phone_number, :fax, :address, :email, :user_id )
    end  

    def options
      {
        user_id: current_user.id
      }
    end
end
