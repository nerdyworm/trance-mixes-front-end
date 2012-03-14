class window.ListensMenuView extends Backbone.View
  className: 'ListensMenuView'

  initialize: (options) ->
    @listens = options.listens
    @listens.bind('add', @addListen, @)
    @listens.bind('reset', @render, @)

  render: ->
    $(@el).empty()
    @listens.each (l) =>
      li = new ListensMenuItemView(model: l)
      $(@el).append li.render().el
    return this

  addListen: (listen) ->
    li = new ListensMenuItemView(model: listen)
    $(@el).prepend(li.render().el)

    if @$('.ListensMenuItemView').length > 20
      @$('.ListensMenuItemView').last().remove()


class ListensMenuItemView extends Backbone.View
  tagName:   'li'
  className: 'ListensMenuItemView'

  events:
    'click a': 'navigate'

  initialize: (options) ->
    @template = HandlebarsTemplates['templates/listens/menu_item']
    @model.bind 'change', @render, @

  render: ->
    if @model.get('mix')
      $(@el).html(@template(@context()))
    else
      $(@el).empty()
    return this

  context: ->
    id: @model.get('mix').id
    title: @model.get('mix').title
    thumb: @model.get('mix').thumb

  navigate: (e) ->
    tm.app.navigateEvent(e)
    return false

class MoreListensMenuItemView extends Backbone.View
  events:
    'click a': 'navigate'

  render: ->
    $(@el).html '<li class="divider"></li><li><a href="/listens">more listens</a>'
    return this

  navigate: (e) ->
    tm.app.navigateEvent(e)
    return false
