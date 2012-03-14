class window.PlayerPlayPauseView extends Backbone.View
  events:
    "click a":  "handleClick"

  initialize: (options) ->
    @template = HandlebarsTemplates['templates/player/play_pause']

    @player = options.player
    @player.bind 'play',   @play, @
    @player.bind 'resume', @play, @
    @player.bind 'stop',   @pause, @
    @player.bind 'pause',  @pause, @
    @player.bind 'finish', @finish, @

  render: ->
    $(@el).html(@template())

  play: ->
    @toggleButton(false)

  pause: ->
    @toggleButton(true)

  finish: ->
    @toggleButton(true)

  handleClick: (e) =>
    e.preventDefault()
    @player.togglePlaying()

  toggleButton: (paused) ->
    @$('a.play').toggle(paused)
    @$('a.pause').toggle(!paused)
