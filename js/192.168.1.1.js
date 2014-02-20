$(function() {
  // Actiontec router firmware constantly asks you if you want to proceed to
  // "Advanced" functions.
  $('td.actiontec_button a:contains("Yes")').click()

  // Allow pasting in a full MAC address
  var input = $('input[name="mac0"]')

  input.attr('maxlength', 17)
  input.on('focus', function() {
    $(this).attr('size', 20)
  }).on('blur', function() {
    $(this).attr('size', 2)
  }).on('change', function() {
    var mac = $(this).val().trim()

    if (mac.match(/[\w:]{17}/)) {
      mac = mac.split(':')
      for(var i = 0; i < mac.length; i++) {
        $('input[name="mac'+i+'"]').val(mac[i])
      }
    }
  })
})
