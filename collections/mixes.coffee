class window.Mixes extends Backbone.Collection
  page: 1
  per_page: 50
  model: Mix
  url: '/mixes'

  initialize: (options={}) ->
    if options.search
      @search = options.search
      @search.mixes = @
      @search.bind 'change', => @page = 1

  nextPage: (success) ->
    unless @fetching
      @fetching = true
      @fetch
        add: true
        data: { page: ++@page }
        success: (collection, array) =>
          @fetching = false
          success(arguments)

          if array.length < @per_page
            collection.trigger 'last-page'

  after: (mix) ->
    index = @indexOf(mix)
    return if index == -1
    index = index + 1
    index = 0 if index >= @size()
    @at(index)

  before: (mix) ->
    index = @indexOf(mix)
    return if index == -1
    index = index - 1
    index = @size() - 1 if index < 0
    @at(index)

