class Services::TaskNotification < Webmate::Services::Base
  subscribe 'task/create' do
    # notify about task creation
  end
end