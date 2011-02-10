path = File.expand_path "../", __FILE__
require "#{path}/alamocoders"

run Sinatra::Application
