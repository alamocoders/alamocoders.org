require File.dirname(__FILE__) + '/../../alamocoders'

require 'rack/test'
require 'capybara/cucumber'
require 'rspec'
After do |s| 
  if User.all(:username=>"foo").count > 0
    User.destroy(:username=>"foo")
  end
end

Capybara.app = Sinatra::Application

class MyWorld
  include Rack::Test::Methods
  include 
  def app
    Sinatra::Application
  end
end

World{MyWorld.new}

