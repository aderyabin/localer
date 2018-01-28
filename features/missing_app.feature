Feature: Localer

Scenario: No rails application
  When I run `localer check`
  Then the checker should not found rails application

Scenario: No rails application at existed paths
  When I run `localer check`
  Then the checker should not found rails application

Scenario: No rails application at not non-existed
  When I run `localer check non-existed_path`
  Then the checker should not found rails application
