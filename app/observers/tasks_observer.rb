class TasksObserver < Webmate::Observers::Base
  subscribe 'tasks/create' do |data|
    TaskNotifierService.new(:user).perform
  end
end