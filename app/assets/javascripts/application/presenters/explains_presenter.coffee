class Application.Presenters.ExplainsPresenter extends Transponder.Presenter
  presenterName: 'explains'
  module: 'application'
  actions: ['show']
  
  show: ->
    $(@element).html(@response)
    $(@element).modal()
