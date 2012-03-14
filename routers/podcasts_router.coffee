class window.PodcastsRouter extends Backbone.Router
  routes:
    "podcasts/:id" : "podcast"
    "podcasts"     : "podcasts"

  initialize: (options) ->
    @app = options.app
    @collections = {}
    @collections.podcasts = new Podcasts()

    @pages = {}
    @pages.podcast = new PodcastPageView()
    @pages.podcasts = new PodcastsPageView(
      podcasts: @collections.podcasts
      router: @
    )

  podcast: (id) ->
    @app.beginPage()

    podcast = @collections.podcasts.get(id)
    if _.isUndefined(podcast)
      podcast = new Podcast(id: id)

    podcast.fetch
      success: =>
        @pages.podcast.setPodcast podcast
        @app.showPage @pages.podcast
      errors: =>
        console.log arguments

  podcasts: ->
    @app.beginPage()
    @collections.podcasts.fetch success: =>
      @app.showPage @pages.podcasts

  navigateEvent: (e) ->
    e.preventDefault()
    @app.navigateEvent(e)
