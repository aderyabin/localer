
<p align="center">
<img title="Localer logo" width="384" height="100" src="https://gist.githubusercontent.com/aderyabin/cb0512cbcd6cb4c79a4d84a4831109a5/raw/localer-logo.png">
</p>

[![Gem Version](https://badge.fury.io/rb/localer.svg)](https://rubygems.org/gems/localer) [![Build Status](https://travis-ci.org/aderyabin/localer.svg?branch=master)](https://travis-ci.org/aderyabin/localer)

Localer is a tool that automatically detects missing I18n translations.

The goal is to preserve the integrity of translations. Localer parses and merges all  application locales’ keys. At the next step, it searches for missing translations among the calculated keys.

<p align="left">
  <img height="500" src="https://gist.githubusercontent.com/aderyabin/cb0512cbcd6cb4c79a4d84a4831109a5/raw/localer2.png">
</p>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'localer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localer

## Usage

At the root directory of a Rails app, run:

    $ localer check .

or for specific Rails path:

    $ localer check /path/to/rails/application

## CI integration

Localer is easy to integrate into your favorite CI workflow:
```yml
# .travis.yml

# other configuration options
script:
  - bundle exec bundle-audit
  - bundle exec rubocop
  - bundle exec rspec
  - bundle exec localer
```

or

```ruby
# Rakefile

# other requirements
require 'localer/rake_task'
Localer::RakeTask.new()

task(:default).clear
task default: [:rubocop, :spec, :localer]
```

## Support

Localer supports
* Ruby: 2.4, 2.5, 2.6, 2.7
* Rails: 5.0, 5.1, 5.2, 6.0, 6.1

## Configuration

The behavior of Localer can be controlled via the `.localer.yml` configuration file. It makes it possible to disable locales and keys. The file can be placed in your project directory.

#### Disable specific locale

By default, Localer enables all locales, but you can disable it:

```yml
Locale:
  EN:
    Enabled: false
```

#### Exclude keys globally
By default, Localer enables all keys, but you can disable keys started with specified string or by regex:

```yml
Exclude:
  - /population\z/
  - .countries.france
```

#### Exclude keys for specific locale
```yml
Locale:
  EN:
    Exclude:
      - /population\z/
      - .countries.france
```

## Using Rake

Localer ships with a rake task. To use Localer's rake task you simply need to require the task file and define a task with it. Below is a rake task that will run `localer`:

```ruby
require 'rubygems'
require 'localer'
require 'localer/rake_task'

Localer::RakeTask.new(:localer)
```

When you now run:

    $ rake -T

you should see

```
rake localer  # Run Localer
```

## Development

After checking out the repo, run `bundle exec appraisal install` to install dependencies for each appraisal. Then, run `bundle exec appraisal rake` to run the tests.

## Built With

* [Thor](https://github.com/erikhuda/thor) - Used for building  command-line interfaces.
* [Appraisal](https://github.com/thoughtbot/appraisal) -  Used for testing against different versions of dependencies
* [Cucumber](https://github.com/cucumber/cucumber) + [Aruba](https://github.com/cucumber/aruba) - Used for testing command-line commands

## Acknowledge
Special thanks to [Roman Shamin](https://www.facebook.com/romanshamin) for the logo.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aderyabin/localer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Localer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aderyabin/localer/blob/master/CODE_OF_CONDUCT.md).
