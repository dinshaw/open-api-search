require 'support/uuid_helper'

ActiveRecord::FixtureSet.context_class.send :include, UuidHelper

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all
end
