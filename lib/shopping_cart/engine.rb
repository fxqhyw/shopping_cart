require 'haml-rails'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    config.autoload_paths << File.expand_path("../lib/some/path", __FILE__)

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
