class window.VideosView extends Backbone.View
  id: "videos-page"
  className: "VideosView"

  events:
    'click .navigate, .play': 'navigate'
    'mouseenter .play': 'hover'
    'mouseleave .play': 'hover'

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/videos/index']

    @videos = options.videos

    @videos.on('reset', @render, @)
    tm.em.on('tm:reflow', @tileVideoLayout, @)

  setThings: ->
    @receivedLastPage = true

  render: =>
    $(@el).html(@template(@context()))
    return this

  context: ->
    videos: @videos.toJSON()

  tileVideoLayout: ->
    return unless $(@el).is(':visible')
    cols = 3
    columnHeights = []
    for i in [0...cols]
      columnHeights.push 0

    videos = @$(".video")
    for video in videos
      $video = $(video)
      height = $video.outerHeight()
      width  = $video.outerWidth()
      index  = getShortestIndex(columnHeights)
      top    = columnHeights[index]
      left   = index * (width + 20)
      $video.css left: left, top: top
      columnHeights[index] += height + 20
    return this

  navigate: (e) ->
    tm.app.navigateEvent(e)
    return false

  hover: (e) ->
    $target = $(e.currentTarget)
    $target.toggleClass 'hover'

    # append a play button while we are here
    if $target.find('.playbutton').length == 0
      $target.append('<img class="playbutton" src="/assets/red_play_large.png"/>')

    # show it if needed
    $target.find('.playbutton').toggle $target.hasClass 'hover'


  getShortestIndex = (heights) ->
    shortestHeight = heights[0]
    shortestIndex  = 0

    for i in [1...heights.length]
      if shortestHeight > heights[i]
        shortestHeight = heights[i]
        shortestIndex = i

    return shortestIndex


