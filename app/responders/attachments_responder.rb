class AttachmentsResponder < BaseResponder
  def create
    task = Task.find(params[:attachment][:task_id])
    params[:files].each do |file|
      attachment = Attachment.new
      attachment.file = file[:tempfile]
      attachment.task_id = task._id
      attachment.save!
    end
  end
end