# Close flash messages
tm.alert = ->
  $(".alert-message").alert()

# Admin links
tm.admin = ->
  $("#admin-show").click ->
    path = window.location.pathname
    $(this).attr 'href', adminPath(path)
    $(this).attr 'target', "_blank"

  $("#admin-edit").click ->
    path = window.location.pathname
    $(this).attr 'href', adminPath(path) + "/edit"
    $(this).attr 'target', "_blank"

  adminPath = (path) ->
    model = path.split("/")[1]
    id = path.split("/")[2]

    admin_path = switch model
      when "mixes"    then  "/admin/mix"
      when "podcasts" then  "/admin/podcast"
      when "artists"  then  "/admin/artist"
      when "videos"   then  "/admin/video"
      else                  "/admin"
    admin_path += "/#{id}" if id
    admin_path

# Bootup the plugins.
#
# This is called from the main Application
tm.plugins = ->
  @alert()
  @admin()
