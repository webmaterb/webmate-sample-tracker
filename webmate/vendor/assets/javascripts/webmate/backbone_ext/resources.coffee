Backbone.Collection = Backbone.Collection.extend
  resourceName: ->
    @resource
  collectionName: ->
    "#{@resource}s"
Backbone.Model = Backbone.Model.extend
  resourceName: ->
    @collection.resourceName()
  collectionName: ->
    @collection.collectionName()
  channel: ->
    _.result(@collection, 'channel')