# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#unit_category_id').parent().hide()
  categories = $('#unit_category_id').html()
  $('#unit_product_id').change ->
    product = $('#unit_product_id :selected').text()
    options = $(categories).filter("optgroup[label='#{product}']").html()
    if options
      $('#unit_category_id').html(options)
      $('#unit_category_id').parent().show()
    else
      $('#unit_category_id').empty()
      $('#unit_category_id').parent().hide()
