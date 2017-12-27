# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "td_ameritrade_institution/version"

Gem::Specification.new do |spec|
  spec.name          = "td_ameritrade_institution"
  spec.version       = TDAmeritradeInstitution::VERSION
  spec.authors       = ["Evan Waters"]
  spec.email         = ["evan@reppro.co"]

  spec.summary       = "A gem to integrate with TD Ameritrade Institutional API"
  spec.homepage      = "http://github.com/reppro/td_ameritrade_institution"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "httparty", "~> 0.15.6"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
