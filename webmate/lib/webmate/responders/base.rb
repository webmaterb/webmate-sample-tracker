module Webmate::Responders
  class Base
    attr_accessor :action, :params

    def initialize(params)
      @params = params
      @action = params[:action]
    end

    def action_method
      action.split('/').last
    end

    def respond
      if respond_to?(action_method)
        response = self.send(action_method)
        async do
          Webmate::Observers::Base.execute_all(
            @action, {action: @action, response: response, params: params}
          )
        end
        [200, wrap_response(response)]
      else
        [404, wrap_response(action: @action, response: "Action ", params: params)]
      end
    end

    def wrap_response(response)
      Yajl::Encoder.new.encode(
        action: @action, response: response, client_id: @params[:client_id]
      )
    end

    def async(&block)
      block.call
    end
  end
end