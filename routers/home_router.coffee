class window.HomeRouter extends Backbone.Router
  routes:
    'genres/:genre/mixes': 'genre'
    '' : 'home'

  initialize: (options) ->
    @app = options.app
    @pages = {}
    @pages.home = new HomeView(
      mixes: tm.collections.mixes,
      home: tm.models.home
    )

    @homeHasRendered = false

  home: =>
    @app.beginPage()
    tm.models.home.fetch success: =>
      @app.showPage @pages.home.render()
      @homeHasRendered = true

  genre: (genre) =>
    @app.beginPage()
    # This conditional kinda means are we loading on a page
    # that already has the home json in it, if so do home page
    # shit, else update the search
    if @homeHasRendered
      tm.models.search.showGenre genre, =>
        @app.showPage @pages.home.render()
    else
      tm.models.home.fetch success: =>
        @app.showPage @pages.home.render()
        @homeHasRendered = true
