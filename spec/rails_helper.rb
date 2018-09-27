ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'rails-controller-testing'
require 'shoulda/matchers'
require 'database_cleaner'
require 'capybara/rails'
require 'factory_bot_rails'
require 'capybara/rspec'
require 'capybara/webkit/matchers'
require 'transactional_capybara/rspec'
require_relative 'support/wait_for_ajax'


FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryBot.factories.clear
FactoryBot.find_definitions

ActiveJob::Base.queue_adapter = :test

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include TransactionalCapybara::AjaxHelpers
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Capybara::Webkit::RspecMatchers, type: :feature
  config.include Warden::Test::Helpers
  config.include WaitForAjax, type: :feature
  config.include ShowMeTheCookies, type: :feature
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
