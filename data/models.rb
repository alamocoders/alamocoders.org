require 'rubygems'
require 'yaml'

class Meeting
  attr_accessor :date, :speaker, :topic, :speaker_job
  path = File.expand_path "../", __FILE__
  @meetings = YAML::load File.open("#{path}/meetings.yml")

  def initialize(date, topic, speaker, speaker_job)
    @date = date
    @topic = topic
    @speaker = speaker
    @speak_job = speaker_job
  end

  def self.next_meeting
    next_meeting = Meeting.new(@meetings[0]["meeting"]["date"],
                               @meetings[0]["meeting"]["topic"],
                               @meetings[0]["meeting"]["speaker"],
                               @meetings[0]["meeting"]["speaker_job"])
  end

  def self.past_meetings
    meetings = []
  end

  def self.future_meetings
    meetings = []
  end
end

