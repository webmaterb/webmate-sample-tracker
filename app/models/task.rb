require 'mongoid'
class Task
  include Mongoid::Document

  field :title
end