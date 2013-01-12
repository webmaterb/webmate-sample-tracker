App.Views.Main = Backbone.View.extend
  start: ->
    $("#create-task-submit").on 'click', ->
      App.main.createTask()
    $("#create-task-input").on 'keypress', (e)->
      if e.keyCode is 13
        App.main.createTask()

    App.tasks = new App.Collections.Tasks()
    App.tasks.on "add", @addTask, @
    App.tasks.on "reset", @renderTasksLists, @
    @client = Webmate.connect 'projects/123', ->
      App.tasks.fetch()
    @bindTasksDraggable()

  addTask: (task)->
    view = new App.Views.Task(model: task)
    $list = $("#tasks-list-#{task.get('status')}")
    $list.append(view.render().el)
    @

  renderTasksLists: ->
    self = @
    $('.tasks-list').empty()
    App.tasks.each (task)->
      self.addTask(task)
    @bindTasksDraggable()
    @

  createTask: ->
    title = $("#create-task-input").val()
    App.tasks.create(title: title)
    $("#create-task-input").val('')
    @

  bindTasksDraggable: ->
    $tasks = $('#tasks-lists .task')
    $tasks.draggable
      containment: 'body'
      cancel: "a.ui-icon"
      cursor: "move"
      helper: 'clone'
      start: (event, ui)->
        $(event.currentTarget).css('opacity', '0')
      stop: (event, ui)->
        $(event.target).css('opacity', '1')
    $('.tasks-list').each ->
      $list = $(this)
      $list.droppable
        accept: ".task",
        drop: (event, ui)->
          $el = $(ui.draggable)
          $el.appendTo($list)
          model = $el.data('view').model
          model.setStatus($list.attr('rel'))


