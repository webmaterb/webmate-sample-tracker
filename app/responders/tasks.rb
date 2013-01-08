class Responders::Tasks < Webmate::Responders::Base
  def list
    Task.all
  end

  def create
    puts data.inspect
    "Create task"
  end
end