#= require jquery
#= require es5-shim
#= require batman
#= require batman.jquery

jQuery ->
  $('a.zoom').on 'click', ->
    $(@).parent().find('.raw').toggle()

  $('a#toggle-all').on 'click', ->
    if $(@).data('state') == 'hidden'
      $('.raw').show()
      $(@).data('state', 'visible')
    else
      $('.raw').hide()
      $(@).data('state', 'hidden')
