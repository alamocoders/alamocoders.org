require 'rspec'
require_relative '../lib/models'

Rspec.configure do |c|
  c.mock_with :mocha
end

MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database = 'alamocoders'
