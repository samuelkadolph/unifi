require File.expand_path("../.gemspec", __FILE__)
require File.expand_path("../lib/unifi/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "unifi"
  spec.version       = Unifi::VERSION
  spec.authors       = ["Samuel Kadolph"]
  spec.email         = ["samuel@kadolph.com"]
  spec.description   = readme.description
  spec.summary       = readme.summary
  spec.homepage      = "https://github.com/samuelkadolph/unifi"
  spec.license       = "MIT"

  spec.files         = files
  spec.executables   = files.executables
  spec.test_files    = files.tests
  spec.require_paths = files.requires

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end