class AttachmentsResponder < BaseResponder
  def create
    puts params[:attachment][:task_id]
    task = Task.find(params[:attachment][:task_id])
    params[:files].each do |file|
      attachment = Attachment.new
      attachment.file = file[:tempfile]
      task.attachments << attachment
    end
    task.save!
    puts task.inspect
    task
  end
end