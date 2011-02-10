path = File.expand_path "../", __FILE__
require 'rubygems'
require 'yaml'

meetings = YAML::load File.open("#{path}/meetings.yml")

require "#{path}/models"
