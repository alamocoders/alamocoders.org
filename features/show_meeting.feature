Feature: Showing Meetings
  In order to get people interested in the upcoming meeting
  As an antendee
  I want to be able to see the next upcoming meeting

  Scenario: Meeting for next month is already listed
    Given The meeting is the same month as I'm viewing but not before
    When I visit the site
    Then I should see the meeting topic, speaker, and when
