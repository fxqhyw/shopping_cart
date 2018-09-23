require "haml"

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    config.generators do |g|
      g.template_engine :haml
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
