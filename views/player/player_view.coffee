class window.PlayerView extends Backbone.View
  initialize: (options={}) ->
    @player = options.player
    @mixView = new PlayerMixView(el: @$("#current_mix"), player: @player)
    @progressView = new PlayerProgressBarView(el: @$("#progress_bar"), player: @player)
    @playPauseView = new PlayerPlayPauseView(el: @$("#controls"), player: @player)

    @volumeView = new PlayerVolumeView(el: $("#volume"), player: @player)
    @volumeView.render()

  render: ->
    @mixView.render()
    @volumeView.render()
    @progressView.render()
    @playPauseView.render()
    $(@el).hide().fadeIn()

  setMix: (mix) ->
    @mix = mix
    @mixView.setMix(mix)
    @progressView.setMix(mix)
    @render()

  whileplaying: (sound) ->
    @progressView.update(sound)


