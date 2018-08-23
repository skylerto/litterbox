# Litterbox

[![Build Status](https://travis-ci.org/skylerto/litterbox.svg?branch=master)](https://travis-ci.org/skylerto/litterbox)
[![Coverage Status](https://coveralls.io/repos/github/skylerto/litterbox/badge.svg?branch=master)](https://coveralls.io/github/skylerto/litterbox?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/6596cfa8b7ee299e775f/maintainability)](https://codeclimate.com/github/skylerto/litterbox/maintainability)

Habitat bindings in Ruby!


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'litterbox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install litterbox

## Usage

For API specific usage read the [docs](http://skylerlayne.me/litterbox/)

### Profiles

A profile essential is a development concept for Habitat, it was born out of the need for multiple habitat depots.

To use profiles, you'll need to drop a config file `~/.litterbox` with the following example content

```
profile = "default"

[on-prem]
origin = "<o-prem origin>"
auth_token = "<on-prem auth_token>"
bldr_url = "<on-prem url>"

[default]
origin = "<my origin>"
auth_token = "<auth_token>"
bldr_url = "https://bldr.habitat.sh"
```

To switch between profiles execute the following:

```
eval "$(litterbox profile set on-prem)"
```

### Build

```
hab = Litterbox::Habitat::Build.new(plan_dir)
hab.build
last_build = Litterbox.last_build("#{plan_dir}/results/last_build.env")
```

### Upload

Currently, the upload needs to be done on the platform that it's being built
from. This is due to a bit of a habitat bug see [habitat-sh/habitat/issues/5010](https://github.com/habitat-sh/habitat/issues/5010)

```
hab = Litterbox::Habitat::Upload.new(
  File.join(plan_dir, 'results', last_build.pkg_artifact),
  ENV['HAB_AUTH_TOKEN']
)

hab.upload
```

### Promote

```
channel = 'stable'
hab = Litterbox::Habitat::Promote.new(
  last_build.pkg_ident,
  channel,
  ENV['HAB_AUTH_TOKEN']
)
hab.promote
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/litterbox. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Litterbox project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/litterbox/blob/master/CODE_OF_CONDUCT.md).
