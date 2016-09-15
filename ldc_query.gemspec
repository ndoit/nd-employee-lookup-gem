$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ldc_query/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ldc_query"
  s.version     = LdcQuery::VERSION
  s.authors     = ["Kingdon Barrett"]
  s.email       = ["kbarret8@nd.edu"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of LdcQuery."
  s.description = "TODO: Description of LdcQuery."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
