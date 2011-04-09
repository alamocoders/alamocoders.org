require File.dirname(__FILE__) + '/../../alamocoders'

begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'rack/test'
require 'capybara/cucumber'

After do |s| 
    User.destroy(:username=>"foo")
end

Capybara.app = Sinatra::Application
