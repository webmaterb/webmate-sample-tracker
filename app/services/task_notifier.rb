class Services::TaskNotifier < Webmate::Services::Base
  def initialize(user)

  end

  def perform
    puts "# send task notification"
  end
end