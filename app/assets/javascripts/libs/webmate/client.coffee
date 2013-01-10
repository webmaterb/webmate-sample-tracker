class Webmate.Client
  constructor: (channel, callback) ->
    self = @
    @bindings = {}
    @channel = channel
    @fullPath = "#{location.host}/#{channel}"
    if window.WebSocket
      @websocket = new WebSocket("ws://#{@fullPath}")
      @websocket.onmessage = (e)->
        response = JSON.parse(e.data)
        eventBinding = self.bindings[response.action]
        _.each eventBinding, (binding)->
          binding(response.data)
      @websocket.onopen = (e)->
        callback()
    else
      console.log("Websocket not supported. Using http.")
      callback()
    @
  on: (action, callback)->
    @bindings[action] = [] if !@bindings[action]
    @bindings[action].push(callback)
    @
  send: (action, data, method)->
    data = {} if !data
    method = 'get' if !method
    data.action = action
    if @websocket
      @websocket.send(JSON.stringify(data))
    else
      $.ajax("http://#{@fullPath}/#{action}", type: method).success (data)->
        console.log(data)
    @
  bindDefaultEvents: (connection)->
    self = @
    _.each App.Collections, (collectionClass)->
      obj = new collectionClass()
      collectionName = obj.collectionName()
      self.on "#{collectionName}/read", (data)->
        collectionInstance = App[collectionName]
        collectionInstance.reset(data);
        collectionInstance.trigger "sync", collectionInstance, data

Webmate.connect = (channel, callback)->
  client = new Webmate.Client(channel, callback)
  Webmate.channels[channel] = client
  client.bindDefaultEvents()
  client
