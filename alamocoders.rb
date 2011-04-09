path = File.expand_path "../", __FILE__
require 'sinatra'
require 'haml'
require "#{path}/data/models"
require_relative "./lib/helpers"

helpers Auth

Database::connect

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

get '/users' do
  protected!
  @users = User.all
  haml :users
end

post '/users/add' do
  protected!
  @user = User.new
  @user.full_name = params[:full_name]
  @user.password = params[:password]
  @user.username = params[:username]
  @user.save
  redirect '/users'
end

get '/users/delete/:id' do |id|
  protected!
  User.destroy(id) 
  redirect '/users'
end

not_found do
  haml :meh, :layout => :mehlayout
end

error do
  haml :meh, :layout => :mehlayout
end
