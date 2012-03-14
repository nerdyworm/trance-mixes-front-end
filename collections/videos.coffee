class window.Videos extends Backbone.Collection
  url: '/videos'
  page: 1
  per_page: 12
  model: Video

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
