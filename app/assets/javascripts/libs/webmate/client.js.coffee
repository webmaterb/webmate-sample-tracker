class Webmate.Client
  constructor: (channel) ->
    self = @
    @bindings = {}
    @websocket = new WebSocket("ws://#{location.host}/#{channel}")
    @websocket.onmessage = (e)->
      response = JSON.parse(e.data)
      eventBinding = self.bindings[response.action]
      _.each eventBinding, (binding)->
        binding(response.data)
    @
  on: (action, callback)->
    @bindings[action] = [] if !@bindings[action]
    @bindings[action].push(callback)
    @
  send: (action, data)->
    data ||= {}
    data.action = action
    @websocket.send(JSON.stringify(data))
    @

Webmate.connect = (channel)->
  new Webmate.Client(channel)