App.Views.Task = Backbone.View.extend
  tagName: "li"
  className: "task"

  initialize: ->
    @model.on "change", @render, @
    @model.view = this
    $.data @el, "view", @
    @

  render: ->
    self = @
    @$el.html ich.tpl_task @model.toJSON()
    @