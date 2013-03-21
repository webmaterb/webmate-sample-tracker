App.Collections.Tasks = Backbone.Collection.extend
  model: App.Models.Task
  channel: 'projects/123'
  resource: 'task'

  initialize: () ->
    @bindSocketEvents()