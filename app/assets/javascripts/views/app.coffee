App.Views.Main = Backbone.View.extend
  start: ->
    self = this
    @client = Webmate.connect 'projects/123', ->
      App.tasks = new App.Collections.Tasks()
      self.benchmarkWebsocket()

    # subscribe to receiving data from websockets
    # @client.on 'tasks/read', (data)->
    #   console.log(data)

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
