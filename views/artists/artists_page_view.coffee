class window.ArtistsPageView extends Backbone.View
  id: 'artists-page-view'

  events:
    'click table a': 'navigate'

  initialize: ->
    @template = HandlebarsTemplates['templates/artists/index']
    @artists = @options.artists
    @artists.bind 'reset', @render, @

  render: ->
    $(@el).html(@template(@toJSON()))
    return this

  toJSON: ->
    artists: @artists.toJSON()

  navigate: (e) ->
    @options.router.navigateEvent(e)

