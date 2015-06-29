class Application.Presenters.CustomersPresenter extends Transponder.Presenter
  presenterName: 'customers'
  module: 'application'
  actions: ['index', 'edit', 'new', 'create', 'update', 'destroy', 'show']

  index: ->
    $(@element).html(@response)
  
  show: ->
    $(@element).replaceWith(@response)

  new: ->
    @edit()

  create: ->
    $(@element).append(@response.content)
    $("#modal-box").modal('hide')

  edit: ->
    $(@element).html(@response)
    $(@element).modal()

  update: ->
    $(@element).replaceWith(@response.content)
    $('#modal-box').modal('hide')

  destroy: ->
    $(@element).fadeOut 500, ->
      $(@element).remove()

    # example
    # @element is the dom element you specified
    # @response is the html fragment rails returned
    # $(@element).html(@response)
    # $(@element).fadeIn(500)