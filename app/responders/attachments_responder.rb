class AttachmentsResponder < BaseResponder
  def create
    task = Task.find(params[:attachment][:task_id])
    params[:files].each do |file|
      attachment = Attachment.new
      attachment.file = file[:tempfile]
      task.attachments << attachment
    end
    task.save
    respond_with(task, action: 'tasks/update')
  end
end