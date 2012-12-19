module Webmate::Responders
  class Base
    attr_accessor :action, :data

    def initialize(data)
      @data = data
      @action = data[:action]
    end

    def respond
      self.send(action.split('/').last)
    end
  end
end