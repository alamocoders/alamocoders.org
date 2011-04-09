require File.dirname(__FILE__) + '/../../alamocoders'

require 'rack/test'
require 'capybara/cucumber'
require 'rspec'
After do |s| 
  User.all(:username=>"jobob").each { |u| User.destroy(u.id) }
  User.all(:username=>"foo").each { |u| User.destroy(u.id) }
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

