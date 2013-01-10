module Webmate::Responders
  class Base
    attr_accessor :action, :params

    def initialize(params)
      @params = params
      @action = params[:action]
    end

    def respond
      response = self.send(action.split('/').last)
      async do
        Webmate::Observers::Base.execute_all(
          @action, {action: @action, response: response, params: params}
        )
      end
      wrap_response(response)
    end

    def wrap_response(response)
      Yajl::Encoder.new.encode({action: @action, response: response})
    end

    def async(&block)
      block.call
    end
  end
end