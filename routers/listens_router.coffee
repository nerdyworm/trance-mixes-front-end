class window.ListensRouter extends Backbone.Router
  routes:
    "listens": "listens"

  initialize: (options) ->
    @app = options.app
    @collections = {}
    @collections.listens = tm.collections.listens

    # XXX Shitty way to check to see if the user is signed in
    unless $("#listens").length == 0
      @collections.listens.fetch()

    @pages = {}
    @pages.listens = new ListensView(
      listens: @collections.listens
      router: @
    )

    @views = {}
    @views.listensMenu = new ListensMenuView(
      el: $('#listens')
      listens: @collections.listens
    )

  listens: ->
    @app.beginPage()
    @collections.listens.fetch success: =>
      @app.showPage @pages.listens

  navigateEvent: (e) ->
    e.preventDefault()
    @app.navigateEvent(e)

