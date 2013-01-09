App.Views.Main = Backbone.View.extend
  start: ->
    self = this
    @client = Webmate.connect 'projects/123', ->
      App.tasks = new App.Collections.Tasks()
      self.benchmarkWebsocket()

  benchmarkWebsocket: ->
    console.log("Benchmark using websockets:")
    benchmark ->
      App.tasks.fetch()
    , 1000

    console.log("Benchmark without websockets:")
    window.WebSocket = false
    benchmark ->
      App.tasks.fetch()
    , 1000