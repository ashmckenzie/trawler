#= require jquery
#= require es5-shim
#= require batman
#= require batman.jquery

jQuery ->
  $('a.zoom').on 'click', ->
    $(@).parent().find('.raw').toggle()
