# Rahasia

[![Build Status](https://travis-ci.org/qontak-dev/rahasia.svg?branch=master)](https://travis-ci.org/qontak-dev/rahasia)

`WARNING` this gem is alpha version. Do not use on production. Currently support String type and ActiveRecord.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rahasia`. To experiment with that code, run `bin/console` for an interactive prompt.

This Gem is wrapper for [Lockbox](https://github.com/ankane/lockbox), [Vault](https://github.com/hashicorp/vault-ruby) and [Vault Transit](https://github.com/jgaxn/vault-transit).

This gem wraps the endpoints for [HashiCorp's Vault Transit secret backend](https://www.vaultproject.io/docs/secrets/transit/). It is dependent upon the [vault gem](https://github.com/hashicorp/vault-ruby). This gem has patterns and code copied from HashiCorp's [vault-ruby gem](https://github.com/hashicorp/vault-rails). Use this gem when you simply want to use the Transit secret backend and you don't need the Rails integration.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rahasia'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rahasia

## Usage

Install Library Rahasia using Rails generator

```
rails generate rahasia:install
```

```ruby
# config/initializer/rahasia.rb
# frozen_string_literal: true

Rahasia.setup do |config|
  config.master_key = 'please-change-me-at-config-initializers-rahasia' # SecureRandom.hex(32)
  config.adapter = 'lockbox' # available ['vault','lockbox']
  config.vault_app = 'qontak'
  config.vault = {address: 'http://localhost', ssl_verify: false, token: 'token'}
end
```

Create Migration to add encrypted_column

```
rails generate rahasia:migration credentials token
```

It will generate column `token` and `token_encrypted`. Please comment the `token` if your column already exists.

```ruby
class RahasiaCredentialstokenUserId < ActiveRecord::Migration
  def change
    add_column :credentials, :token, :string
    add_column :credentials, :token_encrypted, :text
  end
end
```

Run Migration on Rails

```
bundle exec rake db:migrate
```
ig
or for Rails 5 above

```
bundle exec rails db:migrate
```

## Model

```ruby
# app/model/credential.rb
class Credential < ActiveRecord::Base
  include Rahasia
  enrcypt_column :token, type: :string
end
```
## Lockbox

Configuration :
```ruby
Rahasia.setup do |config|
  config.master_key = 'please-change-me-at-config-initializers-rahasia'
  config.adapter = 'lockbox'
end
```

Save encryptrion
```ruby
credential = Credential.new(token: 'ThisIsMyToken!')
credential.save

credential.token # 7GifGwD7+Ls23FX8jyvt5JLWySPGd3300axNyc325sh/
```

On the database save
```
credential.token

# Actual Record on Database:
# '--encrypted:29bb68380340aa4be790438e83400c30---'
# Show on irb:
# ThisIsMyToken!
```
## Vault

```ruby
Rahasia.setup do |config|
  config.adapter = 'vault'
  config.vault_app = 'qontak'
  config.vault = {address: 'http://localhost', ssl_verify: false, token: 'token'}
end
```

Save encryptrion
```ruby
credential = Credential.new(token: 'ThisIsMyToken!')
credential.save

credential.token
```

On the database save
```
credential.token

# Actual Record on Database:
# 'vault:v1:ex/xISRe7exDqeHkIPfTeUmGusyVI/szlwRk83wGyLidc9oO+om2fp6a'
# Show on irb:
# ThisIsMyToken!
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qontak-dev/rahasia. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

TODO:

- [ ] Create Travis for Rails 4, 5, 6
- [ ] Create Travis for Ruby 2.1.0, 2.2.0, 2.3.8, 2.4.5, 2.5.3, 2.6.2
- [ ] Create test for generate installer
- [ ] Create test for generate migration

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rahasia project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/qontak-dev/rahasia/blob/master/CODE_OF_CONDUCT.md).
