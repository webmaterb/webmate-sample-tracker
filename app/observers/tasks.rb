class Observers::Tasks < Webmate::Observers::Base
  subscribe 'tasks/read' do |data|
    Services::TaskNotifier.new(:user).perform
  end
end