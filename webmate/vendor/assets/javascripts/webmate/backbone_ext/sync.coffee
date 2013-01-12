# Improved Backbone Sync
(->
  methodMap =
    create: "POST"
    update: "PUT"
    delete: "DELETE"
    read: "GET"

  getUrl = (object, method) ->
    channel = _.result(object, "channel")
    if channel
      "/#{channel}/#{object.collectionName()}/#{method}"
    else
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
      if model and (method is "create" or method is "update" or method is 'patch')
        data = {}
        data[model.resourceName()] = (options.attrs || model.toJSON())
      client.send("#{model.collectionName()}/#{method}", data, type)
    else
      params =
        type: type
        dataType: "json"
        data: {}

      # Ensure that we have a URL.
      params.url = getUrl(model, method) or urlError()
      # Ensure that we have the appropriate request data.
      if model and (method is "create" or method is "update" or method is "patch")
        params.contentType = "application/json"
        params.data[model.resourceName()] = (options.attrs || model.toJSON())
      params.data = JSON.stringify(params.data)

      # Don't process data on a non-GET request.
      params.processData = false if params.type isnt "GET"
      success = options.success
      options.success = (resp, status, xhr) ->
        success resp.response, status, xhr  if success
        model.trigger "sync", model, resp.response, options

      error = options.error
      options.error = (xhr, status, thrown) ->
        error model, xhr, options  if error
        model.trigger "error", model, xhr, options
      # Make the request, allowing the user to override any Ajax options.
      xhr = Backbone.ajax(_.extend(params, options))
      model.trigger "request", model, xhr, options

).call(this)