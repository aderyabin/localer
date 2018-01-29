Feature: Localer
Scenario: Disable en locale
  Given a real locales
  Given a config file with:
  """
  Locale:
    en:
      Enabled: false
  """
  When I run checker
  Then the checker should pass

Scenario: Disable case-insensitive EN locale
  Given a real locales
  Given a config file with:
  """
  Locale:
    EN:
      Enabled: false
  """
  When I run checker
  Then the checker should pass

Scenario: Disable en.population
  Given a real locales
  Given a config file with:
  """
  Locale:
    en:
      Exclude:
        - .population.italy
  """
  When I run checker
  Then the checker should returns 2 missing translations:
   | en.countries.france.population |
   | en.population.france |

