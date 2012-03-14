class window.Podcast extends Source
  urlRoot: "/podcasts"
  initialize: (options={}) ->
    @mixes = new Mixes()

  parse: (json) ->
    if json.mixes
      @mixes.reset(json.mixes)
      @mixes.url = "/podcasts/#{@id}/mixes"
      delete json.mixes
    json

