module CustomersHelper
  def customers_event
  params[:scope].present? ? params[:scope] : "index"
  end
end