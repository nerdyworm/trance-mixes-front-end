class window.AppRouter extends Backbone.Router
  initialize: ->
    tm.routers.home = new HomeRouter(app: @)
    tm.routers.artists = new ArtistsRouter(app: @)
    tm.routers.mixes = new MixesRouter(app: @)
    tm.routers.podcasts = new PodcastsRouter(app: @)
    tm.routers.videos = new VideosRouter(app: @)
    tm.routers.listens = new ListensRouter(app: @)

    @body     = $("#body")
    @loader   = $("#loader")
    @footer   = $("#footer")
    @spinnyDo = $("#spinnyDo")
    @bindApplicationEvents()

    tm.player = new Player( $("#player") )
    tm.setupErrorHandlers()
    tm.plugins()

  bindApplicationEvents: ->
    tm.em.on 'tm:em:ajax:complete', () ->
      $("#spinnyDo").hide()

    $('#logo, .navigate').click (e) =>
      @navigateEvent(e)

    window.onbeforeunload = ->
      if tm.player.playing()
        return "You are playing music, really leave this page?"

    $(window).scroll ->
      top    = $(window).scrollTop()
      height = $(document).height() - $(window).height()

      if top >= height
        tm.em.trigger 'tm:window_snapped_bottom'

  beginPage: =>
    @fetching = true
    @body.find("> div").hide()
    @footer.hide()
    @loader.show()

  showPage: (page) =>
    @fetching = false
    @loader.hide()
    @footer.show()

    if @body.find(page.el).length == 0
      @body.append(page.el)
    $(page.el).show()
    tm.em.trigger 'tm:reflow'

  showFullScreenPage: (page) =>
    @fetching = false
    @loader.hide()
    @footer.show()

    $body = $('body')
    if $body.find(page.el).length == 0
      $body.prepend(page.el)
    $(page.el).show()


  navigateEvent: (e) ->
    e.preventDefault()
    e.stopPropagation()
    url = $(e.currentTarget).attr('href')
    @navigate(url, true)
    return false

  navigateEventMouseSpinner: (e) ->
    e.preventDefault()
    e.stopPropagation()
    url = $(e.currentTarget).attr('href')

    @spinnyDo.show().css({
      'top':  e.clientY + 20,
      'left': e.clientX
    })

    @navigate(url, false)
    return false


