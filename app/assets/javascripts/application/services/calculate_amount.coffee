class Application.Services.CalculateAmount extends Transponder.Service
  module: 'application'
  serviceName: 'calculate_amount'

  clickButton: ->
    @element.find('.add_nested_fields').on 'click', =>
      setTimeout =>
        field = @element.find('.fields:last')
        @keyup(field)
      , 0

  calculate: ($field) ->
    price = $field.find('.price').val()
    qty   = $field.find('.qty').val()
    sum   = price * qty
    $field.find(".total").val(sum)
    @summation()

  summation:() ->
    sum = 0
    @element.find('.fields').each (_, field) ->
      total = $(field).find('.total').val()
      sum += total*1
    @show_total(sum)

  show_total: (sum) ->
      @element.find('.result').text(sum)
      vat = sum *0.07
      @element.find('.vat').text(vat)
      balance = sum + vat
      @element.find('.balance').text(balance)
      # $result = $(field)
      # console.log field
      # $result.val(sum)

  loadTotal:() ->
    sum = 0
    @element.find('.fields').each (_, field) ->
      total = $(field).find('.total').val()
      sum += total*1
    @element.find('.result').text(sum)
    vat = sum *0.07
    @element.find('.vat').text(vat)
    balance = sum + vat
    @element.find('.balance').text(balance)

  keyup: (field) ->
    $field = $(field)
    $field.find('.qty').keyup => @calculate($field)
    $field.find('.price').keyup => @calculate($field)

  serve: ->
    @clickButton()
    @element.find('.fields').each (_, field) =>
      @keyup(field)
    @loadTotal()
