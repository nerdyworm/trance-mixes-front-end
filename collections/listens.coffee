class window.Listens extends Backbone.Collection
  url: '/listens'
  model: Listen

  initialize: (options) ->
    tm.em.bind 'tm:player:play', @createListen, @
    tm.em.on   'tm:player:finish', @finishMix, @

  createListen: (mix) ->
    mx = { id: mix.id, title: mix.get('title')}
    listen = @create({mix_id: mix.id, mix: mx}, {at: 0})
    mix.listen = listen

  finishMix: (mix) ->
    mix.listen.finish() if mix?.listen
