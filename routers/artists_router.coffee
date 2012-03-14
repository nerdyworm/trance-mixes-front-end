class window.ArtistsRouter extends Backbone.Router
  routes:
    "artists/:id" : "artist"
    "artists"     : "artists"

  initialize: (options) ->
    @app = options.app
    @collections = {}
    @collections.artists = new Artists()

    @pages = {}
    @pages.artist = new ArtistPageView()
    @pages.artists = new ArtistsPageView(
      artists: @collections.artists
      router: @
    )

  artist: (id) ->
    @app.beginPage()

    artist = @collections.artists.get(id)
    if _.isUndefined(artist)
      artist = new Artist(id: id)
      @collections.artists.add(artist)

    artist.fetch
      success: =>
        @pages.artist.setArtist artist
        @app.showPage @pages.artist
      errors: =>
        console.log arguments

  artists: ->
    @app.beginPage()
    @collections.artists.fetch success: =>
      @app.showPage @pages.artists

  navigateEvent: (e) ->
    e.preventDefault()
    @app.navigateEvent(e)


