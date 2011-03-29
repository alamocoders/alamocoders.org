require 'rspec'
require_relative '../data/models'

Rspec.configure do |c|
  c.mock_with :mocha
end
