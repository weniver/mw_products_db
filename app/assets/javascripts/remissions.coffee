# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#remissions').dataTable( {
        "lengthMenu": [[-1], ["Todas las Piezas"]]
    } )

jQuery ->
  $('#remission-show').dataTable( {
        "lengthMenu": [[-1], ["Todas las Piezas"]]
    } )
