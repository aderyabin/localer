Feature: Localer

Scenario: Real locales does not pass
  Given a real locales
  When I run checker
  Then the checker should returns 4 missing translations:
    | ru.population.italy |
    | us.population.italy |
    | en.population.france |
    | en.countries.france.population |