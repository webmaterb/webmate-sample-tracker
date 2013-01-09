class Responders::Tasks < Webmate::Responders::Base
  def read
    #Task.all
    []
  end

  def create
    puts data.inspect
    "Create task"
  end
end