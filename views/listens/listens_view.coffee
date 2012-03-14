class window.ListensView extends TranceView
  id: "listens-page"
  className: "ListensView"

  initialize: (options={}) ->
    @template = HandlebarsTemplates['templates/listens/index']
    @trTemplate = HandlebarsTemplates['templates/listens/tr']
    @listens = options.listens
    @listens.bind('reset', @render, @)
    @listens.bind('add', @addListen)

  render: =>
    $(@el).html(@template(@context()))
    @highlightPlaying()
    return this

  addListen: (listen) =>
    listen.bind 'change:mix', =>
      listen.unbind 'change:mix'
      @denormalizeListen(listen)

      ## table view thingy
      $el = $(@trTemplate(listen.get('mix')))
      @$('.mixes').prepend($el.hide().fadeIn())
      @highlightPlaying()

  context: ->
    @listens.each(@denormalizeListen)
    listens: @listens.toJSON()

  shortContext: ->
    @listens.each(@denormalizeListen)
    listens = []
    for i in [0..10]
      listens.push @listens.at(i).toJSON()

    listens: listens

  denormalizeListen: (listen) ->
    if listen.has('mix')
      mix = listen.get('mix')
      mix.started_at  = listen.get 'started_at'
      mix.finished_at = listen.get 'finished_at'
