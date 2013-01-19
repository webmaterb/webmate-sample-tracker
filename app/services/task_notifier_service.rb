class TaskNotifierService < Webmate::Services::Base
  def initialize(user)

  end

  def perform
    puts "# send task notification"
  end
end