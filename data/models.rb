require 'rubygems'
require 'yaml'
require 'mongo_mapper'
require 'bcrypt'


class Meeting
  include MongoMapper::Document
  
  key :topic, String, :required=>true
  key :kind, String, :required=>true  
  key :date, Date, :required=>true
  key :sponsor, String
  one :speaker

  def formatted_date
    @date.strftime("%A %B %d, %Y")
  end

  def self.get_formatted_date_from(date)
    d = date.split("-")
    d2 = "{#{d[2]},#{d[0]},#{d[1]}}"
    Date.strptime(d2,"{%Y,%m,%d}").strftime("%A %b %d, %Y")
  end

  def self.past_meetings()
    Meeting.where(:date.lt =>Date.today.to_time).sort(:date.desc).all
  end

  def self.next_meeting(kind_type="all")
  if kind_type=="all"
    return Meeting.where(:date.gte=>Date.today.to_time).sort(:date).all
  end
    Meeting.where(:kind=>kind_type,:date.gte=>Date.today.to_time).sort(:date).limit(1).all[0]
  end

end

class Speaker
  include MongoMapper::EmbeddedDocument

  key :bio, String
  key :name, String, :required=>true
  key :job, String

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
