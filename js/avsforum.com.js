$(function() {
  $('a[href$="nextnewest"]').each(function() {
    $(this).parent().remove();
  })
})
