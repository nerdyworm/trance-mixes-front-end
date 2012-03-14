window.Helpers = {
  hms: (milis) ->
    hours   =  parseInt(milis / (1000 * 60 * 60), 10)
    minutes =  parseInt(milis % (1000 * 60 * 60) / (1000 * 60), 10)
    seconds =  parseInt(milis % (1000 * 60 * 60) % (1000 * 60) / 1000, 10)
    seconds = "0#{seconds}" if seconds < 10
    minutes = "0#{minutes}" if minutes < 10
    hours   = "0#{hours}"   if hours < 10
    [hours, minutes, seconds]

  formated_hms: (milis) ->
    [hours, minutes, seconds] = @hms(milis)
    if hours != "00"
      "#{hours}:#{minutes}:#{seconds}"
    else
      "#{minutes}:#{seconds}"
}
