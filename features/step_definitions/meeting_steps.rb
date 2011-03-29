Given /^The meeting is the same month as I'm viewing but not before$/ do
  pending "need to implement database logic"
end

When /^I visit the site$/ do
  pending "need to implement database logic"
  visit '/'
end

Then /^I should see the meeting topic, speaker, and when$/ do 
  pending "need to implement database logic"
  body.should have_content 'Louis Salin'
  body.should have_content 'Better .NET development with Mono'
  body.should have_content 'Wednesday Apr 13, 2011'
end

