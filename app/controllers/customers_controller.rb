class CustomersController < ApplicationController
  before_action :authenticate_user!
  require 'json'

  def index
    @customers = Customer.custom_search(params[:search_method], params[:q], options).results
    
    respond_with @customers
  end

  def show
    @customer = current_user.customers.where(id: params[:id]).first 
    @invoices = @customer.invoices.where(id: params[:id]).first 
    notification_response
  end

  def new

    @customer = current_user.customers.build
    respond_with @customer

  end

  def edit
    @customer = current_user.customers.where(id: params[:id]).first 
    respond_with @customer
  end

  def create
    @customer = current_user.customers.build(customer_params)
    if @customer.save
      respond_with @customer
      push_notify
    else
      xms_error @customer
    end
 
  end

  def update
    @customer = current_user.customers.where(id: params[:id]).first 
    if @customer.update_attributes(customer_params)
      respond_with @customer
      push_notify
    else
      xms_error @customer
    end

  end

  def destroy
    @customer = current_user.customers.where(id: params[:id]).first 
    @customer.destroy

    respond_with do |format|
      format.js do
        respond_with @customer
        push_notify
      end
      format.html do
        Customer.__elasticsearch__.refresh_index!
        redirect_to customers_path, flash: { success: "#{@customer.firstname} has been deleted" }
      end
    end
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

    def notification_response
      if params[:notify].present? 
        render params[:notify]
      else
        respond_with @customer
      end
    end

    def notify_data
      { resource: 'customers', id: @customer.id, action: action_name, who: session[:who] }
    end

    def push_notify
      Pusher.trigger_async("customers", "index", notify_data)
    end
end