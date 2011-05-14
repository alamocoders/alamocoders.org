require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'mongo_mapper'
require 'sinatra'
require_relative './lib/models'
require_relative './lib/helpers'
task :default => [:spec, :features]

desc "Run all specifications"
RSpec::Core::RakeTask.new() do |t|
end

desc "Run all stories"
Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end

desc "Mongo Migrate Script"
task :migrate do 
  Database::connect 
  create_meeting('2011-05-11', 'Git for SVN users', 'Derick Bailey', 'Chief Ninja at Muted Solutions, LLC', '.NET')
  create_meeting('2011-04-27', 'Up and Running with Heroku, MongoDB, and Sinatra', 'Ryan Svihla', 'Software Developer, Carenet', 'Ruby')
  create_meeting('2011-04-13' ,'Better .NET development with Mono ', 'Louis Salin', 'Software Engineer, Compass Learning', '.NET')
  create_meeting('2011-03-09','Test Driven Design (TDD) when working with Razor template engine and ASP.NET MVC', 'Paul Herrera', 'Principal Software Engineer, Tribute', '.NET')
  create_meeting('2011-02-09', 'Redis and Resque', 'Ian Warshak', 'Independent Consultant', 'Ruby')
  create_meeting('2010-12-08', 'Open Discussion', 'The AlamoCoders Group', '', '.NET' )
  create_meeting('2010-11-10', 'Introduction to MVVM with Silverlight', 'Paul Herrera', 'Principal Software Engineer, Tribune', '.NET')
  create_meeting('2010-10-13', 'Simple Sinatra Scripts', 'Aaron Lee', 'Software Developer, Rackspace', 'Ruby')
  create_meeting('2010-09-08', 'Advanced Object Oriented Programming', 'John Teague', 'Owner/Principle Consultant at Avenida Software', '.NET')
  create_meeting("2010-08-11", 'Arudnio',  'Paul Voccio, Matthew Dietz', 'Developer Manager and Software Developer, Rackspace Cloud', 'Arudino')
  create_meeting("2010-07-14", 'Powershell as a Tools Platform', 'Jim Christopher', 'Independent software developer and owner of Code Owls, LLC', '.NET')
  create_meeting("2010-06-09", 'Optimizing your time as a software developer', 'Joe Ocampo', 'Director of Software Development, Rackspace', '.NET')
  create_meeting("2010-05-12", "Functional Programming with Scala", "John Hopper", "Software Developer, Rackspace", "Scala/Java" )
end

def create_meeting(date, topic, speaker_name, job, kind)
  if Meeting.find(:date=>Date.parse(date).to_time)==nil
    speaker = Speaker.new
    speaker.job = job
    speaker.name = speaker_name
    meeting = Meeting.new 
    meeting.date = date
    meeting.speaker = speaker
    meeting.topic = topic
    meeting.kind = kind
    meeting.save
  end
end
