class window.MixPageView extends Backbone.View
  id: 'mix-page'
  className: 'MixPageView'

  events:
    'click .play': 'play'
    'click .navigate': 'navigate'
    'click #next': 'next'
    'click #prev': 'prev'

  initialize: (options) ->
    @template = HandlebarsTemplates['templates/mixes/show']
    tm.em.on 'tm:player:play', @onPlayerPlay, @

  render: ->
    $(@el).html @template(@mix.toJSON())
    @togglePlayingClass()
    @toggleBeforeAfter()
    @

  play: (event) ->
    tm.player.playMix @mix
    return false

  setMix: (mix) ->
    return unless mix
    @mix = mix
    $(@el).attr('data-id', mix.id)
    @render()

  togglePlayingClass: ->
    $(@el).toggleClass 'playing', tm.player.playingMix(@mix)

  toggleBeforeAfter: ->
    @$('#prev').toggle !!@mix.before()
    @$('#next').toggle !!@mix.after()

  onPlayerPlay: (mix) ->
    if @mix and @mix.id == mix.id
      $(@el).addClass 'playing'

  navigate:(e) ->
    tm.app.navigateEvent(e)

  next: (e) ->
    after = @mix.after()
    tm.app.navigate("/mixes/#{after.id}", true)
    return false

  prev: (e) ->
    before = @mix.before()
    tm.app.navigate("/mixes/#{before.id}", true)
    return false
