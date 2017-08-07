# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enoki/version'

Gem::Specification.new do |spec|
  spec.name = "enoki"
  spec.version = Enoki::VERSION
  spec.authors = ["slightair"]
  spec.email = ["arksutite@gmail.com"]

  spec.summary = %q{Code generator for Xcode project.}
  spec.description = %q{Code generator for Xcode project. You can manage multiple user-defined file template set in your project.}
  spec.homepage = "https://github.com/slightair/enoki"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|examples)/})
  end
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "xcodeproj", [">= 1.5", "< 2.0"]
end
