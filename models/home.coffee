class window.HomeModel extends Backbone.Model
  urlRoot: "/"

  initialize: (options={}) ->
    @fetched = false
    @bind 'change:mixes', (home) ->
      tm.collections.mixes.reset(home.get('mixes'))

    @bind 'change:picks', (home) ->
      tm.collections.picks.reset(home.get('picks'))

  fetch: (options={}) ->
    if @fetched and _.isFunction(options.success)
      options.success()
    else
      @fetched = true
      super(options)

  setup: (home) ->
    @fetched = true
    @set(home)
