require 'webmate/responders/callbacks'
module Webmate::Responders
  class Base
    class_attribute :exception_handlers
    attr_accessor :action, :params, :request

    def initialize(request)
      @request = request
      @params = request.params
      @action = params[:action]
    end

    def action_method
      action.split('/').last
    end

    def respond
      process_action
    rescue Exception => e
      handle_exception!(e)
    end

    def process_action
      raise Webmate::Responders::ActionNotFound unless respond_to?(action_method)
      response = self.send(action_method)
      async do
        Webmate::Observers::Base.execute_all(
          action, {action: action, response: response, params: params}
        )
      end
      [200, wrap_response(response)]
    end

    def wrap_response(response)
      Yajl::Encoder.new.encode(
        action: action, response: response, client_id: params[:client_id]
      )
    end

    def render_not_found
      [404, wrap_response(response: "Action not Found")]
    end

    def async(&block)
      block.call
    end

    # If exception have handler, then handle. Else re-raise exception
    def handle_exception!(e)
      handlers = self.class.exception_handlers || {}
      if handlers.include?(e.class)
        block = handlers[e.class]
        instance_eval(&block)
      else
        raise e
      end
    end

    class << self
      def rescue_from(exception, &block)
        self.exception_handlers ||= {}
        self.exception_handlers[exception] = block
      end
    end

    include Webmate::Responders::Callbacks
  end
end