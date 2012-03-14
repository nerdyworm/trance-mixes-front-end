class window.ArtistPageView extends TranceView
  id: 'artist-page-view'

  initialize: (options) ->
    @template = HandlebarsTemplates['templates/artists/show']

  render: ->
    $(@el).html(@template(@toJSON()))
    return this

  setArtist: (artist) ->
    @artist = artist
    @render()

  toJSON: ->
    @artist.toJSON()

