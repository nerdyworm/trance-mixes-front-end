class window.HomeView extends Backbone.View
  id: 'home-page'
  className: 'HomeView'

  fetched:
    false

  events:
    'click #load': 'load'

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/home/index']

    @home = options.home
    @mixes = tm.collections.mixes
    @picks = tm.collections.picks

    tm.em.on 'tm:window_snapped_bottom', =>
      if $(@el).is(":visible")
        @load()

    @initializeSubViews()

  initializeSubViews: ->
    $(@el).html(@template())

    @genreFilterView = new GenreFilterView({
      el: @$('#genres'),
      search: tm.models.search,
    })

    @mixesView = new MixesView({
      el: @$('#mixes .mixes'),
      mixes: @mixes,
    })

    @staffView = new MixesView({
      el: @$('#staff .mixes'),
      mixes: @picks
    })

    @loadmore = new Loadmore(@)
    @loadmore.collection = tm.collections.mixes

  render: =>
    @genreFilterView.render()
    @mixesView.render()
    @staffView.render()
    @

  load: (event) =>
    @loadmore.load(event)
    return false

