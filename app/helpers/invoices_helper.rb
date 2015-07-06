module InvoicesHelper
  def invoices_title
    if @customer.present?
      "Invoices for #{@customer.firstname} #{@customer.lastname}"
    else
      "All Invoices"
    end
  end
end
