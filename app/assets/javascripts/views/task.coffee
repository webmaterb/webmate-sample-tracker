App.Views.Task = Backbone.View.extend
  tagName: "li"
  className: "task"
  events:
    "click .delete": "delete"

  initialize: ->
    @model.on "change", @render, @
    @model.view = this
    $.data @el, "view", @
    @

  render: ->
    self = @
    @$el.html ich.tpl_task @model.toJSON()
    @renderFileUploader()
    @

  delete: ->
    @model.destroy()
    @$el.empty().remove()
    App.tasks.remove(@model)
    @

  renderFileUploader: ->
    self = @
    @$el.on
      'dragenter dragover': ->
        $(this).addClass "file-hover"
      dragleave: ->
        $(this).removeClass "file-hover"
    @$el.find('.attachment-uploader').fileupload
      url: "/projects/123/attachments/create"
      dropZone: @$el
      add: (e, data)->
        data.formData =
          'attachment[task_id]': self.model.get "_id"
        data.submit()
