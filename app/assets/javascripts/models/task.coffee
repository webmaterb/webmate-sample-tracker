App.Models.Task = Backbone.Model.extend
  defaults:
    status: 'backlog'
  setStatus: (status)->
    @save(status: status)