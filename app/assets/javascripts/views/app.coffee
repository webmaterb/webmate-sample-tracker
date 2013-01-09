App.Views.Main = Backbone.View.extend
  start: ->
    Webmate.connect 'projects/123', ->
      App.tasks = new App.Collections.Tasks()
      App.tasks.fetch()