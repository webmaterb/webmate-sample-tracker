module Webmate
  module Authentication
    module Helpers

      # The main accessor to the warden middleware
      def warden
        request.env['warden']
      end

      # Check the current session is authenticated to a given scope
      def signed_in?(scope = nil)
        scope ? warden.authenticated?(scope) : warden.authenticated?
      end

      # Authenticate a user against defined strategies
      def authenticate(*args)
        warden.authenticate!(*args)
      end

      # Terminate the current session
      def sign_out(scopes = nil)
        scopes ? warden.logout(scopes) : warden.logout(warden.config.default_scope)
      end

      # Store the logged in user in the session
      def sign_in(new_user, opts = {})
        warden.set_user(new_user, opts)
      end

      # Require authorization for an action
      def authenticate!(scope)
        unless authenticated?(scope)
          session[:return_to] = request.path
          redirect(configatron.authentication.failure_path)
        end
      end

      def authentication_for(scope)
        Warden::Manager.serialize_into_session(scope) { |user| user.nil? ? nil : user._id }
        Warden::Manager.serialize_from_session(scope) { |id| id.nil? ? nil : Strategies::Password.find(scope, id) }

        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def authenticate_#{scope}!
            authenticate!(:#{scope})
          end

          def #{scope}_signed_in?
            signed_in?(:#{scope})
          end

          def current_#{scope}
            @current_#{scope} ||= warden.user(:#{scope})
          end

          def #{scope}_session
            current_#{scope} && warden.session(:#{scope})
          end
        METHODS

        resource_name = scope.to_s
        resource_class = resource_name.classify.constantize
        collection_name = scope.to_s.pluralize

        locals = {
          resource_name: resource_name,
          collection_name: collection_name,
          resource_class: resource_class
        }

        get "/#{collection_name}/sign_in" do
          resource = resource_class.new
          locals[:resource] = resource
          slim :'/sessions/new', locals: locals
        end

        post "/#{collection_name}/sign_in" do
          authenticate(scope: scope)
          redirect session[:return_to] ? session.delete(:return_to) : configatron.authentication.success_path
        end

        post "/#{collection_name}/unauthenticated" do
          redirect configatron.authentication.failure_path
        end

        get "/#{collection_name}/sign_out" do
          authenticate(scope: scope)
          sign_out(scope)
          redirect configatron.authentication.logout_path
        end
      end

      def self.registered(app)
        app.register Warden
        app.helpers Webmate::Authentication::Helpers

        # Enable Sessions
        app.set :sessions, true

        unless Warden && Warden::Manager
          raise "WardenPlugin::Error - Install warden with 'gem install warden' to use plugin!"
        end
        app.use Warden::Manager do |manager|
          manager.default_strategies :password
          manager.default_scope = :user
          manager.failure_app = app
        end
        Warden::Manager.before_failure { |env, opts| env['REQUEST_METHOD'] = "POST" }
        Warden::Strategies.add(:password, Webmate::Authentication::Strategies::Password)
      end
    end
  end
end