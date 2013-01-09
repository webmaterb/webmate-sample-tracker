App.Collections.Tasks = Backbone.Collection.extend
  model: App.Models.Task
  channel: 'projects/123'
  url: '/projects/123/tasks/read' # TODO: auto create url from channel
  paramRoot: 'task'
