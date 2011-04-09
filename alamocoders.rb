path = File.expand_path "../", __FILE__
require 'sinatra'
require 'haml'
require "#{path}/data/models"

if ENV['MONGOHQ_HOST']
  puts "Running on MongoHQ" 
  MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_HOST'], ENV['MONGOHQ_PORT'])
  MongoMapper.database = ENV['MONGOHQ_DATABASE']
  MongoMapper.database.authenticate(ENV['MONGOHQ_USER'],ENV['MONGOHQ_PASSWORD'])
else
  puts "Using local database" 
  MongoMapper.database = 'alamocoders'
end

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
  @users = User.all
  haml :users
end

post '/users/add' do
  @user = User.new
  @user.full_name = params[:full_name]
  @user.password = params[:password]
  @user.username = params[:username]
  @user.save
  redirect '/users'
end

get '/users/delete/:id' do |id|
  User.destroy(id) 
  redirect '/users'
end

not_found do
  haml :meh, :layout => :mehlayout
end

error do
  haml :meh, :layout => :mehlayout
end
