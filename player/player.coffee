tm.em ||= _.extend({}, Backbone.Events)

class window.Player extends Backbone.View
  volume: 100

  constructor: ($player) ->
    @view = new PlayerView(el: $player, player: this)

    # proxy all events to this mix
    @bind 'all', (name) =>
      tm.em.trigger("tm:player:#{name}", @mix) 

    @bind 'finish', =>
      @finished = true

    @bind 'play', =>
      @finished = false

    @events =
      play: =>
        @trigger('play')
      stop: =>
        @trigger('stop')
      pause: =>
        @trigger('pause')
      resume: =>
        @trigger('resume')
      finish: =>
        @trigger('finish')

      whileloading: =>
        @update_playing() if @mix.paused

      whileplaying: =>
        @view.whileplaying(@sound)

      #bufferchange: =>
        #console.log "events.bufferchange", arguments

  playMix: (mix) ->
    @setMix(mix) and @play()

  setMix: (mix) ->
    return false unless mix
    return false if @mix and @mix.id == mix.id

    @mix = mix

    @view.setMix(mix)
    @setup()

  setPosition: (ms) ->
    if @finished
      @setupAndPlay()
    else
      @sound.setPosition(ms) if @sound

  setUrl: (url) ->
    @sound.destruct() if @sound
    @sound = soundManager.createSound
      id: 'current_mix'
      url: url
      autoLoad: false
      onplay: @events.play
      onstop:  @events.stop
      onpause: @events.pause
      onresume: @events.resume
      onfinish: @events.finish
      onbufferchange: @events.bufferchange
      whileloading: @events.whileloading
      whileplaying: @events.whileplaying
      volume: @volume
    @sound

  setVolume: (volume) ->
    @volume = volume
    @sound.setVolume(volume) if @sound

  playing: ->
    @sound and @sound.playState == 1

  paused: ->
    @sound and @sound.paused

  playingMix: (mix) ->
    return false unless @mix
    @mix.id == mix.id

  loading: ->
    @sound and @sound.readyState == 1

  play: ->
    @sound and @sound.play()

  pause: ->
    @sound and @sound.pause()

  stop: ->
    @sound and @sound.stop()

  resume: ->
    @sound and @sound.resume()

  togglePlaying: =>
    if (!@sound and @mix) || @finished
      return @setupAndPlay()

    if @paused() then @resume() else @pause()

  setupAndPlay: =>
    @setup()
    @play()

  setup: =>
    @setUrl(@mix.get('download_url'))
    tm.em.trigger('tm:mix:loaded', @mix)
