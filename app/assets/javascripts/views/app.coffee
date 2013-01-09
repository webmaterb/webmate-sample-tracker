App.Views.Main = Backbone.View.extend
  start: ->
    client = Webmate.connect 'projects/123', ->
      App.tasks = new App.Collections.Tasks()
      App.tasks.fetch()
    client.on 'tasks/read', (data)->
      console.log(data)