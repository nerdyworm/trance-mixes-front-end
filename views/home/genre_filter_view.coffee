class window.GenreFilterView extends Backbone.View
  events:
    'click a[data-genre]': 'click'
    'click a.clear': 'clear'

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/home/genres']
    @search   = options.search
    @search.bind 'change', @render, @

  render: ->
    $(@el).html(@template(@context()))
    return this

  click: (e) ->
    $link = $(e.currentTarget)
    genre = $link.data('genre')
    tm.app.navigateEventMouseSpinner(e)
    tm.models.search.showGenre(genre)
    return false

  clear: (e) ->
    @search.clear()
    tm.app.navigateEventMouseSpinner(e)
    return false

  context: ->
    genres = []
    activeGenres = @search.get('genres')

    for g in tm.genres
      genre = {
        name: g,
        active: ''
      }

      if _.include(activeGenres, g)
        genre.active = 'active'

      genres.push genre

    all_active = _.all(genres, (g) -> g.active == 'active')
    clear_active = if all_active then '' else 'active'

    return {
      genres: genres,
      search_id: @search.id,
      clear_active: clear_active
    }

