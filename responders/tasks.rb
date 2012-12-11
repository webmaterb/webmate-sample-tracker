module Responders
  class Tasks
    def initialize(action)
    end

    def respond(data = nil)
      if data[:action] == 'tasks/create'
        "Create task"
      else
        "Hello Tasks"
      end
    end
  end
end