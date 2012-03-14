tm.em ||= _.extend({}, Backbone.Events)

class window.Mix extends Backbone.Model
  urlRoot: "/mixes"

  initialize: ->
    tm.em.on 'tm:player:play',   @play, @
    tm.em.on 'tm:player:finish', @finish, @

  finish: ->
    @set(listen_state: 'finished')

  play: ->
    @set(listen_state: 'started')

  before: ->
    @collection?.before(@)

  after: ->
    @collection?.after(@)

# Should this be on the collection?
# Add it if not there or something...
Mix.find = (id, callback) ->
  if tm.collections.mixes
    mix = tm.collections.mixes.get(id)
    if mix
      callback(mix)
    else
      mix = new Mix
      mix.id = id
      mix.fetch(success: (mix) -> callback(mix))


