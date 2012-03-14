class window.MixesView extends TranceView
  stache: 'templates/mixes/mixes'
  subView: MixView

  initialize: (options={}) ->
    @template = HandlebarsTemplates[this.stache]
    @setMixes options.mixes

  render: =>
    $(@el).html @template({
      mixes: @mixes.toJSON()
    })
    @setPlaying tm.player.mix
    @

  setMixes: (mixes) =>
    @mixes = mixes
    @mixes.bind 'add',    @addMix
    @mixes.bind 'reset',  @render

  addMix: (mix) =>
    $(@el).append new @subView(mix: mix).render().el
