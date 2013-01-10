class Responders::Tasks < Webmate::Responders::Base
  def read
    Task.all
  end

  def create
    "Create task"
  end
end