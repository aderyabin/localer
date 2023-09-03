Feature: Localer

Scenario: No locales files
  When I run checker
  Then the checker should pass

Scenario: Empty en locale
  Given a "en" locale file with:
  """
  en:
  """
  When I run checker
  Then the checker should pass

Scenario: Empty ru locale
  Given a "ru" locale file with:
  """
  ru:
  """
  When I run checker
  Then the checker should pass

Scenario: Complete locales
  Given a "en" locale file with:
  """
  en:
    one: one
  """
  Given a "ru" locale file with:
  """
  ru:
    one: один
  """
  Given a "us" locale file with:
  """
  us:
    one: one
  """
  When I run checker
  Then the checker should pass

Scenario: Empty en locale
  Given a "ru" locale file with:
  """
  ru:
    one: один
  """
  When I run checker
  Then the checker should fail

Scenario: Empty en locale creates a json dump
  Given a "ru" locale file with:
  """
  ru:
    one: один
  """
  When I run checker with json
  Then the checker should fail
  And the checker should create a json dump with:
  """
  ["en.one","us.one"]
  """

Scenario: Incorrect structure
  Given a "en" locale file with:
  """
  en:
    too_long: "Too Long"
  """
  Given a "ru" locale file with:
  """
  ru:
    too_long:
      one: слишком большой длины (не может быть больше чем %{count} символ)
      other: слишком большой длины (не может быть больше чем %{count} символа)
  """
  When I run checker
  Then the checker should fail
