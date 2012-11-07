Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include FixtureFile
end

require 'no_change_please'