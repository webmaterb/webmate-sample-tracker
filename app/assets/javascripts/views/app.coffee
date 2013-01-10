App.Views.Main = Backbone.View.extend
  start: ->
    self = this
    @client = Webmate.connect 'projects/123', ->
      App.tasks = new App.Collections.Tasks()
      App.tasks.fetch()
      #self.benchmarkWebsocket()

  benchmarkWebsocket: ->
    console.log("Benchmark using websockets:")
    benchmark ->
      App.tasks.fetch()
    , 100
    window.WebSocket = false
    console.log("Benchmark without websockets:")
    benchmark ->
      App.tasks.fetch()
    , 100
