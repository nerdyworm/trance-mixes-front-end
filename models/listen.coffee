class window.Listen extends Backbone.Model
  urlRoot: '/listens'
  finish: ->
    @save finished_at: new Date()

