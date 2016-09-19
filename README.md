# Central::Support

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/central/support`. To experiment with that code, run `bin/console` for an interactive prompt.

This is a library that moves away some of the logic from [Central](https://github.com/Codeminer42/cm42-central) so we can reuse in other projects. Particularly the Iteration calculation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'central-support'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install central-support

## Usage

This library expects a very specific set of pre-existing models (Team, Project, Story, User, Activity, Enrollment, Membership, and Ownership).

They are all models that exist in Central and they must also follow a specific database schema.

If you want to use this library in another application, refer to the `spec/support/rails_app/` so you know exactly how your new app should look like.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Codeminer-42/central-support.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

