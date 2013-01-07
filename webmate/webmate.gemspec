# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require 'webmate/version'

Gem::Specification.new do |gem|
  gem.name          = "webmate"
  gem.version       = Webmate::VERSION

  gem.authors       = ["Iskander Haziev"]
  gem.email         = ["gvalmon@gmail.com"]
  gem.description   = %q{Real-time web application framework in Ruby}
  gem.summary       = %q{Real-time web application framework in Ruby}
  gem.homepage      = "https://github.com/droidlabs/webmate"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = "webmate"
  gem.require_paths = ["lib"]
end
