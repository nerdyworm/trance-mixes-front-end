class window.VideosRouter extends Backbone.Router
  routes:
    "videos/:id" : "video"
    "videos"     : "videos"

  initialize: (options) ->
    @app = options.app
    @collections = {}
    @collections.videos = new Videos()

    @pages = {}
    @pages.videos = new VideosView(
      videos: @collections.videos
      router: @
    )
    @pages.video = new VideoPageView(
      router: @
    )

    tm.em.on 'tm:stoped-video', =>
      @watchingvideo = false

  video: (id) ->
    if $(@pages.videos.el).is(':visible')
      @watchVideo(id)
    else
      @collections.videos.fetch success: =>
        @app.showPage @pages.videos
        @watchVideo(id)

  watchVideo: (id) ->
    @watchingVideo = true

    video = @collections.videos.get(id)
    @pages.video.setVideo video
    @app.showFullScreenPage @pages.video

  videos: ->
    if @isWatchingVideo()
      @pages.video.stopVideo()

    @app.beginPage()
    @collections.videos.fetch success: =>
      @app.showPage @pages.videos
      @pages.video.stopVideo()

  navigateEvent: (e) ->
    e.preventDefault()
    @app.navigateEvent(e)

  isWatchingVideo: ->
    @watchingVideo
