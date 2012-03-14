class window.PodcastsPageView extends Backbone.View
  id: "podcasts-page"
  className: "PodcastsPageView"

  events:
    'click .navigate': 'navigate'

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/podcasts/index']
    @podcasts = options.podcasts
    @podcasts.bind 'reset',  @render
    @podcasts.bind 'change', @render

  render: =>
    $(@el).html(@template(podcasts: @podcasts.toJSON()))
    return this

  navigate: (e) ->
    tm.app.navigateEvent(e)
