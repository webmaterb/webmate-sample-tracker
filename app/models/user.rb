class User
  include Mongoid::Document
  include Webmate::Authentication::Model

  has_many :tasks
end