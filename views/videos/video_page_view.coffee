class window.VideoPageView extends Backbone.View
  id: "video-page"
  className: "VideoPageView"

  events:
    'click .stop-video': 'stopVideo'
    'click .prev': 'prev'
    'click .next': 'next'

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/videos/show']
    @youtubeTemplate = HandlebarsTemplates['templates/videos/large_youtube']

  render: =>
    $(@el).html(@template(@video.toJSON()))
    return this

  setVideo: (video) ->
    @video = video
    @render()

  stopVideo: (e) ->
    @$('iframe').remove()
    $(@el).hide()
    tm.app.navigate('/videos')
    tm.em.trigger 'tm:stoped-video'
    return false

  prev: (e) ->
    prev = @video.collection.before(@video)
    tm.app.navigate("/videos/#{prev.id}", true)
    return false

  next: (e) ->
    next = @video.collection.after(@video)
    tm.app.navigate("/videos/#{next.id}", true)
    return false
