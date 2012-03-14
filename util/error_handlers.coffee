tm.setupErrorHandlers = ->
  $(document).ajaxSend ->
    tm.em.trigger 'tm:em:ajax:send', arguments

  $(document).ajaxComplete ->
    tm.em.trigger 'tm:em:ajax:complete', arguments

  $(document).ajaxError (error, xhr, settings, exception) ->
    #console.log xhr.status, xhr.responseText, "EXCEPTION: " + exception
    #message = if xhr.status == 0
                #"The server could not be contacted :-<  Please refresh your browser and try again."
              #else if xhr.status == 403
                #"Login is required for this action."
              #if 500 <= xhr.status <= 600
                #"There was an error on the server :-("
    #$('#error-message span').text message
    #$('#error-message').slideDown()
    if needsLogin(xhr)
      displaySignupFormOnNeedsLogin()

    if isServerUnReachable(xhr)
      $('#error-message span').text "The server could not be contacted :-<  Please refresh your browser and try again."
      $('#error-message').slideDown()
      $('#loader').hide()

  needsLogin = (xhr) ->
    xhr.status == 401

  isServerError = (xhr) ->
    500 <= xhr.status <= 600

  isServerUnReachable = (xhr) ->
    xhr.status == 0

  displaySignupFormOnNeedsLogin = ->
    return if hasSeenSignUpPlead()
    $("#sign-up-plead").show()

    $("#no").click ->
      hideSignUpPleadForTwoDays()
      $("#sign-up-plead").hide()


  hasSeenSignUpPlead = ->
    cookies = document.cookie.split(';')
    try
      for cookie in cookies
        [key, value] = cookie.split('=')
        if key.trim() == 'seen-plead'
          return true
      return false
    catch e
      return false

  hideSignUpPleadForTwoDays = ->
    date = new Date()
    date.setTime(date.getTime() + twoDaysInMS())
    expires = "expires="+date.toGMTString()
    document.cookie = "seen-plead=true; #{expires}"

  twoDaysInMS = ->
    2*24*60*60*1000
