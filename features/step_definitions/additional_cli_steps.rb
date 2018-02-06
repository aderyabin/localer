# frozen_string_literal: true

Given /^a "(.*)" locale file with:$/ do |locale, file_content|
  write_file("#{LOCALE_DIR}/#{locale}.yml", file_content)
end

Given /^a config file with:$/ do |file_content|
  write_file(CONFIG_PATH, file_content)
end

Given /^a real locales$/ do # rubocop:disable Metrics/BlockLength
  steps %{
    Given a "en" locale file with:
    """
    en:
      population:
        italy: 60.6
      countries:
        italy:
          city: Rome
        spain:
          city: Madrid
        france:
          city: Paris
    """
    Given a "ru" locale file with:
    """
    ru:
      population:
        france: 66.9
      countries:
        italy:
          city: Рим
        spain:
          city: Мадрид
        france:
          city: Париж
          population: 66.9
    """
    Given a "us" locale file with:
    """
    us:
      population:
        france: 66.9
      countries:
        italy:
          city: Rome
        spain:
          city: Madrid
        france:
          city: Paris
          population: 66.9
    """
  }
end

Then /^the checker should pass$/ do
  step 'the output should contain "✔ No missing translations found"'
  step 'the exit status should be 0'
end

Then /^the checker should fail$/ do
  step 'the output should contain "✖ Missing translations found"'
  step 'the exit status should be 1'
end

Then /^the checker should create a json dump with:$/ do |file_content|
  file_name = 'tmp/aruba/output.json'
  output = File.exist?(file_name) ? File.read(file_name) : ''
  expect(output).to eql(file_content)
end

Then /^the checker should returns (.*) missing translations:$/ do |int, translations|
  step %{the output should contain "✖ Missing translations found (#{int})"}
  translations.raw.each do |tr|
    step %{the output should match /^#{Regexp.escape('* ' + tr[0])}$/}
  end

  step 'the exit status should be 1'
end

Then /^the checker should not found rails application$/ do
  step 'the output should contain "No Rails application found"'
  step 'the exit status should be 1'
end

When /^I run checker$/ do
  run("localer check ../../spec/dummy_app")
end

When /^I run checker with json$/ do
  run("localer check ../../spec/dummy_app --json output.json")
end
