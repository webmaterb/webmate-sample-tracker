App.Collections.Tasks = Backbone.Collection.extend
  model: App.Models.Task
  channel: 'projects/123'
  paramRoot: 'task'
