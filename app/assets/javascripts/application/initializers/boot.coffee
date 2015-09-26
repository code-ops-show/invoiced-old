# this file will boot up your transponder app

# presenters
new Application.Presenters.CustomersPresenter()
new Application.Presenters.InvoicesPresenter()
new Application.Presenters.ExplainsPresenter()


# services
new Application.Services.Notification()
new Application.Services.CalculateAmount()