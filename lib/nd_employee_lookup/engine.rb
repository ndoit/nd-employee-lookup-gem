module NdEmployeeLookup
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
    isolate_namespace NdEmployeeLookup

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
