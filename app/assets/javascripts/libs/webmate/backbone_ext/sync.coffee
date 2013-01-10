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
        data[model.resourceName()] = model.toJSON()
      client.send("#{model.collectionName()}/#{method}", data, type)
    else
      # Default options, unless specified.
      _.defaults options or (options = {}),
        emulateHTTP: Backbone.emulateHTTP
        emulateJSON: Backbone.emulateJSON

      # Default JSON-request options.
      params =
        type: type
        dataType: "json"

      # Ensure that we have a URL.
      params.url = getUrl(model, method) or urlError()

      # Ensure that we have the appropriate request data.
      if not options.data? and model and (method is "create" or method is "update" or method is "patch")
        params.contentType = "application/json"
        params.data = JSON.stringify(options.attrs or model.toJSON(options))

      # For older servers, emulate JSON by encoding the request into an HTML-form.
      if options.emulateJSON
        params.contentType = "application/x-www-form-urlencoded"
        params.data = (if params.data then model: params.data else {})

      # For older servers, emulate HTTP by mimicking the HTTP method with `_method`
      # And an `X-HTTP-Method-Override` header.
      if options.emulateHTTP and (type is "PUT" or type is "DELETE" or type is "PATCH")
        params.type = "POST"
        params.data._method = type  if options.emulateJSON
        beforeSend = options.beforeSend
        options.beforeSend = (xhr) ->
          xhr.setRequestHeader "X-HTTP-Method-Override", type
          beforeSend.apply this, arguments_  if beforeSend

      # Don't process data on a non-GET request.
      params.processData = false  if params.type isnt "GET" and not options.emulateJSON
      success = options.success
      options.success = (resp, status, xhr) ->
        success resp.data, status, xhr  if success
        model.trigger "sync", model, resp.data, options

      error = options.error
      options.error = (xhr, status, thrown) ->
        error model, xhr, options  if error
        model.trigger "error", model, xhr, options

      # Make the request, allowing the user to override any Ajax options.
      xhr = Backbone.ajax(_.extend(params, options))
      model.trigger "request", model, xhr, options

).call(this)