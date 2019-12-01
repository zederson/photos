require 'simplecov'

SimpleCov.start 'rails'

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/poltergeist'
require 'webmock/rspec'

WebMock.allow_net_connect!

abort("The Rails environment is running in production mode!") if Rails.env.production?

#Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods

  Capybara.javascript_driver = :poltergeist
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, window_size: [1680, 1280])
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!


  config.after(type: :feature) { WebMock.disable_net_connect!(allow_localhost: true) }

  config.before(:each) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
  end

  config.append_after(:each) do
    Capybara.reset_sessions!
  end

  config.include Rails.application.routes.url_helpers

  config.use_transactional_fixtures = false

  config.before(:each) do
    driver_shares_db_connection_with_specs =
      Capybara.current_driver == :rack_test
  end

  config.append_after(:each) do
    Capybara.reset_sessions!
  end
end
