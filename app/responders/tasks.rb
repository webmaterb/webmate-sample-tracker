class Responders::Tasks < Webmate::Responders::Base
  def read
    current_user.tasks
  end

  def create
    task = Task.new(params[:task])
    task.user_id = current_user.id
    task.save
    task
  end

  def update
    task = Task.find(params[:_id])
    task.update_attributes(params[:task])
    task
  end
end