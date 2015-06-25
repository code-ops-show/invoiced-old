add_fields = (link, association, content) ->
  new_id = (new Date).getTime()
  regexp = new RegExp('new_' + association, 'g')
  $(link).parents('table').find('tbody').append content.replace(regexp, new_id)
  return
