class Responders::Base < Webmate::Responders::Base
  # Available options
  # before_filter :do_something

  rescue_from Webmate::Responders::ActionNotFound do
    render_not_found
  end
end