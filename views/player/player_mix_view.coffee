class window.PlayerMixView extends Backbone.View
  events:
    'click': 'show'

  initialize: (options={}) ->
    @player = options.player
    @template = HandlebarsTemplates['templates/player/mix']

  render: ->
    $(@el).html @template(@player.mix.toJSON()) if @player.mix
    @

  setMix: (mix) ->
    @mix = mix

  show: (e) ->
    tm.app.navigate('/mixes/' + @mix.id, true)
    return false
