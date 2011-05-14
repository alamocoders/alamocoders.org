path = File.expand_path "../", __FILE__
require 'sinatra'
require 'haml'
require "#{path}/lib/models"
require "#{path}/lib/helpers"

helpers Auth
helpers View

begin
    Database::connect
rescue
end

get '/' do
  @next_meetings = Meeting.where(:date.gte=>Date.today.yesterday.to_time).sort(:date).limit(4).all
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

get '/meetings/add' do
  protected!
  haml :add_meeting
end

post '/meetings' do
  protected!
  meeting = Meeting.new
  meeting.kind = params["kind"]
  meeting.topic = params["topic"]
  meeting.time = params["time"]
  meeting.date = DateTime.strptime(params["date"], "%m/%d/%Y").to_time
  if params["where"] == "panera bread"
    meeting.location_map = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=new+horizons+computer+learning+center+san+antonio&sll=38.22623,-85.570149&sspn=0.00799,0.019248&ie=UTF8&hq=new+horizons+computer+learning+center&hnear=San+Antonio,+TX&ll=29.517137,-98.555453&spn=0.012324,0.022724&t=h&z=16&iwloc=A"
    meeting.location_name = "Panera Bread"
  elsif params["where"] == "other"
    meeting.location_map = params["location_map"]
    meeting.location_name = params["location_name"]
  end
  unless params["speaker_name"].to_s == ''
    speaker = Speaker.new
    speaker.name = params["speaker_name"]
    speaker.job = params["speaker_job"]
    meeting.speaker = speaker
  end
  meeting.save!
  redirect '/meetings'
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
