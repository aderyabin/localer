# Localer

[![Build Status](https://travis-ci.org/aderyabin/localer.svg?branch=master)](https://travis-ci.org/aderyabin/localer) [![Gem Version](https://badge.fury.io/rb/localer.svg)](https://rubygems.org/gems/localer)

<img align="center" height="500" src="https://gist.githubusercontent.com/aderyabin/cb0512cbcd6cb4c79a4d84a4831109a5/raw/localer2.png">

Automatic detecting missing I18n translations tool.

<a href="https://evilmartians.com/">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54"></a>


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
```
localer check .
```
or for specific Rails path:
```
localer check /path/to/rails/application
```
## Supported Ruby/Rails versions

Localer is supported for the following versions:

|          | Rails 4.1 | Rails 4.2 | Rails 5.0 | Rails 5.1 |
|----------|:---------:|:---------:|:---------:|:---------:|
| Ruby 2.3 |     +     |     +     |     +     |     +     |
| Ruby 2.4 |     -     |     -     |     +     |     +     |
| Ruby 2.5 |     -     |     -     |     +     |     +     |

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

## Development

After checking out the repo, run `bundle exec appraisal install` to install dependencies for each appraisal. Then, run `bundle exec appraisal rake` to run the tests.

## Built With

* [Thor](https://github.com/erikhuda/thor) - Used for building  command-line interfaces.
* [Appraisal](https://github.com/thoughtbot/appraisal) -  Used for testing against different versions of dependencies
* [Cucumber](https://github.com/cucumber/cucumber) + [Aruba](https://github.com/cucumber/aruba) - Used for testing command-line commands

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aderyabin/localer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Localer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aderyabin/localer/blob/master/CODE_OF_CONDUCT.md).
