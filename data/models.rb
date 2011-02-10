class Meeting
  attr_accessor :date, :speaker, :topic, :speaker_job
  def self.next_meeting
    current_month_meeting_date = Meeting.second_wednesday_of(Time.now.month, Time.now.year)
    next_month_meeting_date = Meeting.second_wednesday_of(Time.now.month == 12 ? 1 : Time.now.month + 1, Time.now.year + (Time.now.month == 12 ? 1 : 0))
    current_date = Date.parse(Time.now.to_s)

    date_to_look_for = current_date > current_month_meeting_date ? next_month_meeting_date : current_month_meeting_date
    next_meeting = Meeting.where("date_of LIKE ?", "%#{date_to_look_for}%")
    next_meeting[0] ||= Meeting.new(:date_of => date_to_look_for,:topic => 'TBD',:speaker => 'TBD')
  end

  def self.past_meetings
    meetings = Meeting.where("date_of < ?", Date.parse(Time.now.to_s)).sort.reverse
  end

  def self.future_meetings
    meetings = Meeting.where("date_of > ?",Time.parse(second_wednesday_of(Time.now.month == 12 ? 1 : Time.now.month + 1, Time.now.year + (Time.now.month == 12 ? 1 : 0)).to_s).strftime("%Y-%m-%d %H:%M:%S")).sort.reverse
  end

  def self.second_wednesday_of(month, year)
    date = Date.new(year, month, 8)
    date += 1 until date.wday == 3
    date
  end

  def <=>(other_meeting)
    Time.parse(self.date_of.to_s) <=> Time.parse(other_meeting.date_of.to_s)
  end
end

