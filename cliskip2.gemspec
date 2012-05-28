# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cliskip2/version"

Gem::Specification.new do |s|
  s.name        = "cliskip2"
  s.version     = Cliskip2::VERSION
  s.authors     = ["Naoki Maeda"]
  s.email       = ["maeda.na@gmail.com"]
  s.homepage    = "http://wiki.github.com/maedana/cliskip2"
  s.summary     = %q{A Ruby wrapper for the SKIP2 REST APIs}
  s.description = %q{A Ruby wrapper for the SKIP2 REST APIs}

  s.rubyforge_project = "cliskip2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'faraday_middleware', '~> 0.8.7'
  s.add_dependency 'simple_oauth', '~> 0.1.8'
  s.add_dependency 'oauth', '~> 0.4'
  s.add_development_dependency('rake')
  s.add_development_dependency('rake-compiler')
  s.add_development_dependency('rspec', '~> 2')
end
