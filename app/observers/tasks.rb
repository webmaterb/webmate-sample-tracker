class Observers::Tasks < Webmate::Observers::Base
  subscribe 'tasks/create' do |data|
    Services::TaskNotifier.new(:user).perform
  end
end