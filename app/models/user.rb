class User
  include Mongoid::Document
  include Webmate::Authentication::Model
end