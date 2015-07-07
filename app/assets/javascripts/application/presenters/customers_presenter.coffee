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
    toastr.success(@response.notification)

  edit: ->
    $(@element).html(@response)
    $(@element).modal()

  update: ->
    $(@element).replaceWith(@response.content)
    $('#modal-box').modal('hide')
    toastr.success(@response.notification)

  destroy: ->
    $(@element).fadeOut 500, ->
      $(@element).remove()
    toastr.info(@response.notification)

  error: 
    update: (errors, element) ->
      for key, value of errors
        $("input#customer_#{key}").tooltip
          title: value[0]
        $("input#customer_#{key}").tooltip('show')

    create: (errors, element) ->
      @update(errors, element)