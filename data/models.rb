require 'rubygems'
require 'yaml'
require 'mongo_mapper'
require 'bcrypt'

class Meeting
  attr_accessor :date, :speaker, :topic, :speaker_job
  path = File.expand_path "../", __FILE__
  @meetings = YAML::load File.open("#{path}/meetings.yml")

  def initialize(date, topic, speaker, speaker_job)
    @date = date
    @topic = topic
    @speaker = speaker
    @speaker_job = speaker_job
  end

  def self.get_formatted_date_from(date)
    d = date.split("-")
    d2 = "{#{d[2]},#{d[0]},#{d[1]}}"
    Date.strptime(d2,"{%Y,%m,%d}").strftime("%A %b %d, %Y")
  end

  def self.next_meeting
    formatted_date = get_formatted_date_from(@meetings[0]["meeting"]["date"])

    next_meeting = Meeting.new(formatted_date,
                               @meetings[0]["meeting"]["topic"],
                               @meetings[0]["meeting"]["speaker"],
                               @meetings[0]["meeting"]["speaker_job"])
  end

  def self.past_meetings
    meetings = []
    for i in 1..@meetings.length-1
      formatted_date = get_formatted_date_from(@meetings[i]["meeting"]["date"])
      meetings << Meeting.new(formatted_date,
                               @meetings[i]["meeting"]["topic"],
                               @meetings[i]["meeting"]["speaker"],
                               @meetings[i]["meeting"]["speaker_job"])
    end
    meetings
  end
end


class User
  include MongoMapper::Document

  key :username, String, :required=>true
  key :password_hash, String, :required=>true
  key :full_name, String, :required=>true


  def password
    BCrypt::Password.new(@password_hash) 
  end
  def password=(new_password)
    @password_hash = BCrypt::Password.create(new_password)
  end
 
end
