path = File.expand_path "../", __FILE__
require 'sinatra'
require 'haml'
require "#{path}/data/models"


get '/' do
  @next_meeting = Meeting.next_meeting
  haml :index
end

get '/information' do
  haml :information
end

get '/meetings' do
  @next_meeting = Meeting.next_meeting
  @past_meetings = Meeting.past_meetings
  haml :meetings
end

not_found do
  haml :meh, :layout => :mehlayout
end

error do
  haml :meh, :layout => :mehlayout
end
