class window.PlayerProgressBarView extends Backbone.View
  events:
    "mouseup   .progress-container": "mouseup"
    "mousedown .progress-container": "mousedown"
    "mousemove .progress-container": "mousemove"

  initialize: (options={}) ->
    @player = options.player
    @template = HandlebarsTemplates['templates/player/progress_bar']

  setMix: (mix) ->
    @mix = mix

  mouseup: (e) ->
    x = @getX(e)
    @scrubbed(x)
    @scrubbing = false

  mousedown: (e) ->
    e.preventDefault()
    @scrubbing = true

  mousemove: (e) ->
    e.preventDefault()
    x = @getX(e)
    @scrubbed(x)

  scrubbed: (x) ->
    @player.setPosition((x / @width) * @duration) if @scrubbing

  render: ->
    $(@el).html @template(@player.mix.toJSON()) if @player.mix
    @grabElements()

  grabElements: ->
    bar       = @$(".progress-bar")
    @loading  = bar.find(".loading")
    @progress = bar.find(".progress")
    @width    = bar.width()
    @$current = @progress.find(".current")

  renderUpdate: ->
    @progress.css width: @progressed * @width
    @loading.css width: @loaded * @width
    @$current.text(Helpers.formated_hms(@current))

  update: (sound) ->
    @duration = sound.durationEstimate
    @current = sound.position
    @progressed = sound.position / sound.durationEstimate
    @loaded = sound.bytesLoaded / sound.bytesTotal
    @renderUpdate()

  getX: (e) ->
    e.pageX - $(e.currentTarget).offset().left
