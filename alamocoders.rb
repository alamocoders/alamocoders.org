path = File.expand_path "../", __FILE__
require 'sinatra'
require 'haml'
require "#{path}/data/models"
require_relative "./lib/helpers"

helpers Auth
helpers View

begin
    Database::connect
rescue
end

get '/' do
  @next_meetings = Meeting.where(:date.gte=>Date.today.to_time).sort(:date.desc).limit(4).all.sort {|m| m.date}
  haml :index
end

get 'about' do 
  haml :about
end

get '/information' do
  haml :information
end

get '/meetings' do
  @upcoming_meetings = Meeting.next_meeting()
  @past_meetings = Meeting.past_meetings()
  haml :meetings
end

post '/meetings/add' do
  protected!
  Meeting.create(params)
  redirect '/users'
end

get '/meetings/delete/:id' do |id|
  protected!
  Meeting.destroy(id) 
  redirect '/users'
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
