class Responders::Base < Webmate::Responders::Base
  rescue_from Webmate::Responders::ActionNotFound do
    render_not_found
  end
end