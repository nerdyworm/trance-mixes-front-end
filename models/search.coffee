class window.Search extends Backbone.Model
  urlRoot: '/searches'
  defaults: {
    genres: [
      'uplifting',
      'progressive',
      'vocal',
      'techno',
      'tech',
      'trance',
      'bigroom',
      'psy',
      'j00f'
    ],
    page: 1
  }

  initialize:(options={})->

  addGenre: (genre) ->
    genres = @get 'genres'
    genres.push(genre)
    @save({genres: genres})

  removeGenre: (genre) ->
    genres = @get 'genres'
    @save({genres: _.without(genres, genre)})

  toggleGenre: (genre, toggle) ->
    if toggle then @addGenre(genre) else @removeGenre(genre)

  selectGenre: (genre) ->
    @save({genres: [genre]})

  showGenre: (genre, callback) ->
    @save({genres: [genre]}, success: callback)

  clear: ->
    @save(@defaults)

  parse: (json) ->
    @mixes.reset json.mixes
    delete json.mixes
    json

  toJSON: ->
    attrs = _.clone( this.attributes )
    delete attrs.mixes

    return { search: attrs }
