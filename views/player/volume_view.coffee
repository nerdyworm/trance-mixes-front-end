class window.PlayerVolumeView extends Backbone.View
  events:
    "hover .box": "hover"
    "click img": "click"

  initialize: (options) ->
    @player = options.player

  render: =>
    @$('.slider').slider @sliderConfig()

  sliderConfig: =>
    min: 0
    max: 100
    value: @volume()
    range: "min"
    slide: @slide
    orientation: "vertical"

  click: (e) ->
    $(@el).toggleClass 'hover'

  hover: (e) ->

  slide: (event, ui) =>
    @player.setVolume(ui.value)

  volume: ->
    @player.volume
