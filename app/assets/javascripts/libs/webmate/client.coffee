class Webmate.Client
  constructor: (channel, callback) ->
    self = @
    @bindings = {}
    @channel = channel
    @fullPath = "#{location.host}/#{channel}"
    if window.WebSocket
      @websocket = new WebSocket("ws://#{@fullPath}")
      @websocket.onmessage = (e)->
        data = JSON.parse(e.data)
        eventBinding = self.bindings[data.action]
        _.each eventBinding, (binding)->
          binding(data.response)
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
      return unless obj
      collectionName = obj.collectionName()
      self.on "#{collectionName}/read", (response)->
        collectionInstance = App[collectionName]
        return unless collectionInstance
        collectionInstance.reset(response);
        collectionInstance.trigger "sync", collectionInstance, response

Webmate.connect = (channel, callback)->
  client = new Webmate.Client(channel, callback)
  Webmate.channels[channel] = client
  client.bindDefaultEvents()
  client
