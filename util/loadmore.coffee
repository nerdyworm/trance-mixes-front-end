class window.Loadmore
  constructor: (view) ->
    @view = view

  load: (event, callback) =>
    unless _.isUndefined event
      event.preventDefault()

    @callback = callback

    # Short views just get reset so we can just pull down
    # a full page of things
    if @collection.size() == 5
      @collection.reset([], silent: true)

    @startLoading()
    @collection.nextPage(@finishLoading)

    @collection.on 'last-page', =>
      @view.$("#loadmore").hide()

    @collection.on 'reset', =>
      @view.$("#loadmore").show()

  startLoading: =>
    @view.$('#loading').show()
    @view.$('#loadmore').hide()

  finishLoading: =>
    @view.$('#loading').hide()
    @view.$('#loadmore').show()
    if _.isFunction(@callback)
      @callback()
