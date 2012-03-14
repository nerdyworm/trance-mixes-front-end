class window.MixesRouter extends Backbone.Router
  routes:
    "mixes/:id" : "mix"

  initialize: (options) ->
    @app = options.app
    @pages = {}
    @pages.mix = new MixPageView()

  mix: (id) ->
    @app.beginPage()

    Mix.find id, (mix) =>
      @pages.mix.setMix mix
      @app.showPage @pages.mix

  navigateEvent: (e) ->
    e.preventDefault()
    @app.navigateEvent(e)


