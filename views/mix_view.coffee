class window.MixView extends BaseMixView
  className: "mix"

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/mixes/mix']
    @setMix options.mix

  render: ->
    $(@el).html @template(@mix.toJSON())
    $(@el).data('id', @mix.id)
    $(@el).addClass @mix.get 'listen_state'

    if tm.player.playingMix @mix
      $(@el).addClass 'playing'
    @
