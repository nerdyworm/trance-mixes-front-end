class window.PodcastPageView extends TranceView
  events: ->
    _.extend(super(),{
      'click #loadmore': 'load'
    })

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/podcasts/show']
    @loadmore = new Loadmore(@)

  render: =>
    $(@el).html(@template(@context()))
    # ok this needs to be somewhere else?
    # event listener? just playing state?
    @setPlaying tm.player.mix

  setPodcast: (podcast) ->
    @podcast = podcast
    @podcast.mixes.page = 0
    @podcast.mixes.bind 'reset', =>
      @render()
    , @
    @render()
    @loadmore.collection = @podcast.mixes

  context: ->
    json = @podcast.toJSON()
    json.mixes = @podcast.mixes.toJSON()
    json

  load: (event) =>
    @loadmore.load(event, @render)
    return false

