class Responders::Tasks < Webmate::Responders::Base
  def read
    Task.all
  end

  def create
    Task.create(params[:task])
  end
end