$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nd_employee_lookup/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nd_employee_lookup"
  s.version     = NdEmployeeLookup::VERSION
  s.authors     = ["Kingdon Barrett"]
  s.email       = ["kbarret8@nd.edu"]
  s.homepage    = "https://bitbucket.com/nd-oit/nd-employee-lookup-gem"
  s.summary     = "Lookup ND employees by name or by NetID"
  s.description = "Rails Engine plugin to enable lookup and cacheing of employee records"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'foundation-rails', '~> 5.3.1'
  s.add_development_dependency 'jquery-rails', '~> 4.2.1'
end
