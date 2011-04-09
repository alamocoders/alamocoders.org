Feature: admin panel
  In order to allow directors to modify the site
  As a director
  I want to add another director so they can modify the site

    Scenario: New Director
    Given I have access to the admin panel
    When I add the user from the admin panel
    Then they will show up in the list of directors

    Scenario: Hacker
    Given The hacker does not have an account
    When he tries to access /users/
    Then he will be denied
