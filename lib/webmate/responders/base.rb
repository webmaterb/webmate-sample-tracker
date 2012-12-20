module Webmate::Responders
  class Base
    attr_accessor :action, :data

    def initialize(data)
      @data = data
      @action = data[:action]
    end

    def respond
      response = self.send(action.split('/').last)
      wrap_response(response)
    end

    def wrap_response(response)
      Yajl::Encoder.new.encode({action: @action, data: response})
    end
  end
end