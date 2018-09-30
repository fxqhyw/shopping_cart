$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "loker-shopping-cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["therealloker"]
  s.email       = ["therealloker@gmail.com"]
  s.homepage    = "https://github.com/therealloker/shopping_cart"
  s.summary     = "Summary of ShoppingCart."
  s.description = "Description of ShoppingCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.2.1"
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'devise'
  s.add_dependency 'aasm'
  s.add_dependency 'country_select'
  s.add_dependency 'wicked'
  s.add_dependency 'draper'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-turbolinks'
  s.add_dependency 'rectify'
  s.add_dependency 'cancancan'
  s.add_dependency 'turbolinks', '~> 5'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'show_me_the_cookies'
end
