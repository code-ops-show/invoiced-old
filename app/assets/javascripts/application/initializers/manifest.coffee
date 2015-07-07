Application.services_manifest = ->
  $('body.customers.index').trigger 'application:services:notification'
  # fill in your manifest here
  # example:
  # if you want to trigger a service on your entire app
  # $('body').trigger 'application:services:service_name'
  # 
  # If you want a more fine grained control for 
  # different pages you can add a class to your body 
  # in your views/layouts/application.html.erb
  # on your body tag you can do something like this
  #
  # <body class="[controller_name] [action_name]">
  #
  # You now have a more fine grained control in 
  # your manifest file
  # $('body.posts.show').trigger 'application:services:service_name'
  #
  # if you need to trigger the same services on multiple pages
  # $('body.posts.show,
  #    body.dashboard.show,
  #    body.photos.index').trigger 'application:services:service_name'
  # 

Application.run_ready = ->
  Application.services_manifest()

  window.add_fields = (link, association, content) ->
    new_id = (new Date).getTime()
    regexp = new RegExp('new_' + association, 'g')
    $(link).parents('table').find('tbody').append content.replace(regexp, new_id)
    return

  $ ->
    $('#login-form-link').click (e) ->
      $('#login-form').delay(100).fadeIn 100
      $('#register-form').fadeOut 100
      $('#register-form-link').removeClass 'active'
      $(this).addClass 'active'
      e.preventDefault()

    $('#register-form-link').click (e) ->
      $('#register-form').delay(100).fadeIn(100, -> $(@).removeClass('hidden'))
      $('#login-form').fadeOut 100
      $('#login-form-link').removeClass 'active'
      $(this).addClass 'active'
      e.preventDefault()

$(document).ready Application.run_ready
$(document).on 'page:load', Application.run_ready
$.fn.datepicker.defaults.format = "dd/mm/yyyy"
$('.selectpicker').selectpicker();