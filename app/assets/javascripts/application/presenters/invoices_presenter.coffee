class Application.Presenters.InvoicesPresenter extends Transponder.Presenter
  presenterName: 'invoices'
  module: 'application'

  index: ->
    # example
    # @element is the dom element you specified
    # @response is the html fragment rails returned
    # $(@element).html(@response)
    # $(@element).fadeIn(500)