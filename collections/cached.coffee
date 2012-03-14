class window.Cached extends Backbone.Collection
  fetch: (options={}) ->
    if @fetched and _.isFunction(options.success)
      options.success()
    else
      @fetched = true
      super(options)
