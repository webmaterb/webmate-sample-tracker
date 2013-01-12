App.Views.Main = Backbone.View.extend
  start: ->
    @$list = $('#tasks-list')
    $("#create-task-submit").on 'click', ->
      App.main.createTask()
    $("#create-task-input").on 'keypress', (e)->
      if e.keyCode is 13
        App.main.createTask()

    App.tasks = new App.Collections.Tasks()
    App.tasks.on "add", @addTask, @
    App.tasks.on "reset", @renderTasksList, @
    @client = Webmate.connect 'projects/123', ->
      App.tasks.fetch()

  addTask: (task)->
    view = new App.Views.Task(model: task)
    @$list.append(view.render().el)

  renderTasksList: ->
    self = @
    @$list.empty()
    App.tasks.each (task)->
      self.addTask(task)
    @

  createTask: ->
    title = $("#create-task-input").val()
    App.tasks.create(title: title)
    $("#create-task-input").val('')
    @
