module NdEmployeeLookup
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
    isolate_namespace NdEmployeeLookup

    config.assets.paths << File.expand_path("../../assets/stylesheets", __FILE__)
    config.assets.paths << File.expand_path("../../assets/javascripts", __FILE__)
    config.assets.precompile += %w( nd_employee_lookup/employee_lookup.js nd_employee_lookup/employee_lookup.css
                                    nd_employee_lookup/employee_lookup_full.js )

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
