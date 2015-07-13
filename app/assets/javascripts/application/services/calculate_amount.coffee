class Application.Services.CalculateAmount extends Transponder.Service
  module: 'application'
  serviceName: 'calculate_amount'

  click_button_item: ->
    @element.find('.add_nested_fields').on 'click', =>
      setTimeout =>
        field = @element.find('.fields_line_items:last')
        @key_line_item_up(field)
      , 0

  calculate: ($field) ->
    price = $field.find('.price').val()
    qty   = $field.find('.qty').val()
    sum   = price * qty
    $field.find(".total").val(sum)
    @summation()

  summation:() ->
    sum = 0
    @element.find('.fields_line_items').each (_, field) ->
      total = $(field).find('.total').val()
      sum += total*1
    @show_total(sum)

  show_total: (sum) ->
      @element.find('.result').text(sum)
      vat = sum * (vat_value/100)
      @element.find('.vat').text(vat.toFixed(2))
      balance = sum + vat
      @element.find('.balance').text(balance)

  loadTotal:() ->
    vat_value = @element.find('.vat-value').text()
    sum = 0
    @element.find('.fields_line_items').each (_, field) ->
      total = $(field).find('.total').val()
      sum += total*1
    vat = sum * (vat_value/100)
    balance = sum + vat
    @element.find('.result').text(sum)
    @element.find('.vat').text(vat.toFixed(2))
    @element.find('.balance').text(balance)

  key_line_item_up: (field) ->
    $field = $(field)
    $field.find('.qty').keyup => @calculate($field)
    $field.find('.price').keyup => @calculate($field)

    #-------------------  amout ---------------------------------

  click_button_payment: ->
    @element.find('.add_payment').on 'click', =>
      setTimeout =>
        field = @element.find('.fields_payments:last')
        @key_payment_up(field)
      , 0

  key_payment_up: (field) ->
    $field = $(field)
    $field.find('.amount').keyup => @calculate_payment($field)

  calculate_payment: ($field) ->
    total_paid = 0
    @element.find('.fields_payments').each (_, field) ->
      amount = $(field).find('.amount').val()
      total_paid += amount*1
    subtotal = @get_subtotal()
    payment  = subtotal*1 - total_paid*1
    @show_payment(payment,total_paid)

  calculate: ($field) ->
    price = $field.find('.price').val()
    qty   = $field.find('.qty').val()
    sum   = price * qty
    $field.find(".total").val(sum)
    @summation()

  show_payment: (payment,total_paid) ->
    @element.find('#total_paid').text(total_paid)
    @element.find('#balance_payment').text(payment.toFixed(2))

  get_subtotal: () ->
    vat_value = @element.find('.vat-value').text()
    sum = 0
    @element.find('.fields_line_items').each (_, field) ->
      total = $(field).find('.total').val()
      sum += total*1
    vat = sum * (vat_value/100)
    balance = sum + vat
    return balance

  serve: ->
    @click_button_item()
    @element.find('.fields_line_items').each (_, field) =>
      @key_line_item_up(field)
    @loadTotal()
    @element.find('.fields_payments').each (_, field) =>
      @key_payment_up(field)
    @click_button_payment()

