Feature: Localer
Scenario: Exclude strings
  Given a real locales
  Given a config file with:
  """
  Exclude:
    - .countries.france
    - .population
  """
  When I run checker
  Then the checker should pass

Scenario: Exclude regexp
  Given a real locales
  Given a config file with:
  """
  Exclude:
    - /population\z/
  """
  When I run checker
  Then the checker should pass

Scenario: Exclude strict regexp
  Given a real locales
  Given a config file with:
  """
  Exclude:
    - /^.population/
  """
  When I run checker
  Then the checker should returns 1 missing translations:
    | en.countries.france.population |
