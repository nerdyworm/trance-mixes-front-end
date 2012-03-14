# Show the user's change password fields
$(document).ready ->
  $("#show-passwords").click ->
    $(this).parent().parent().hide()
    $("#password-fields").fadeIn()
    return false

