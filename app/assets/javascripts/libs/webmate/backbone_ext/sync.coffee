# Improved Backbone Sync
(->
  methodMap =
    create: "POST"
    update: "PUT"
    delete: "DELETE"
    read: "GET"

  getUrl = (object) ->
    return null unless object and object.url
    (if _.isFunction(object.url) then object.url() else object.url)

  getChannel = (object) ->
    return null unless object and object.channel
    (if _.isFunction(object.channel) then object.channel() else object.channel)

  urlError = ->
    throw new Error("A 'url' property or function must be specified")

  window.Backbone.sync = (method, model, options) ->
    type = methodMap[method]
    if window.WebSocket
      client = Webmate.channels[getChannel(model)]
      if model and (method is "create" or method is "update")
        data = {}
        data[model.paramRoot] = model.toJSON()
      client.send("#{model.paramRoot}s/#{method}", data, type)
    else
      params = _.extend(
        type: type
        dataType: "json"
        beforeSend: (xhr) ->
          token = $("meta[name=\"csrf-token\"]").attr("content")
          xhr.setRequestHeader "X-CSRF-Token", token  if token
          model.trigger "sync:start"
      , options)
      params.url = getUrl(model) or urlError()  unless params.url
      if not params.data and model and (method is "create" or method is "update")
        params.contentType = "application/json"
        data = {}
        data[model.paramRoot] = model.toJSON()
        params.data = JSON.stringify(data)
      params.processData = false  if params.type isnt "GET"
      complete = options.complete
      options.complete = (jqXHR, textStatus) ->
        model.trigger "sync:end"
        complete jqXHR, textStatus  if complete
      $.ajax(params)

).call(this)