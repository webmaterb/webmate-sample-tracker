module Webmate::Services
  class Base
    class << self
      cattr_accessor :subscriptions

      def subscribe(action, &block)
        Webmate::Services::Base.subscribe!(action, &block)
      end

      def subscribe!(action, &block)
        self.subscriptions ||= {}
        self.subscriptions[action] ||= []
        self.subscriptions[action] << block
      end
    end
  end
end