# Set up globaly available models and collections tm.em ||= _.extend({}, Backbone.Events) 

tm.models.home = new HomeModel()
tm.models.search = new Search()

tm.collections.listens = new Listens()
tm.collections.picks = new Mixes()
tm.collections.mixes = new Mixes({
  search: tm.models.search
})

$(document).ready ->
  tm.app = new AppRouter()
  Backbone.history.start pushState: true
