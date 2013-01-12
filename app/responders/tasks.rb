class Responders::Tasks < Webmate::Responders::Base
  def read
    Task.all
  end

  def create
    Task.create(params[:task])
  end

  def update
    task = Task.find(params[:_id])
    task.update_attributes(params[:task])
    task
  end
end