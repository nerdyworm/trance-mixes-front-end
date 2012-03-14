class window.BaseMixView extends Backbone.View
  play: (e) =>
    tm.player.playMix @mix
    e.preventDefault()
    e.stopPropagation()

  navigate: (e) =>
    tm.app.navigateEvent(e)

  setMix: (mix) =>
    @mix = mix
    @mix.view = @
    @mix.bind 'play', @render, @

