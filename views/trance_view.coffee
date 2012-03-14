class window.TranceView extends Backbone.View
  events: ->
    'click .play': 'play'
    'click .show': 'navigate'
    'click .navigate': 'navigate'
    "mouseenter .mix": "mouseenter"
    "mouseleave .mix": "mouseleave"

  mouseenter: (e) =>
    @$(e.currentTarget).addClass 'hover'

  mouseleave: (e) =>
    @$(e.currentTarget).removeClass 'hover'

  play: (e) =>
    e.preventDefault()
    e.stopPropagation()

    $target = ($ e.currentTarget)
    mix_id  = $target.data 'id'

    # This is like the transition state
    # 
    # 1. react to input
    # 2. state to begin to change
    # 3. move from chaging to changed
    # 4. profit?
    @setPlayingId mix_id
    Mix.find mix_id, (mix) =>
      tm.player.playMix mix

  navigate: (e) =>
    tm.app.navigateEvent(e)

  setPlayingId: (id) =>
    $('.playing').removeClass 'playing'
    $(".mix[data-id=#{id}]").addClass('playing').removeClass("new").addClass("started")
    $("#mix-page[data-id=#{id}]").addClass('playing')

  highlightPlaying: ->
    unless _.isUndefined tm.player.mix
      @setPlayingId(tm.player.mix.id)

  setPlaying: (mix) =>
    return unless mix
    @setPlayingId(mix.id)
