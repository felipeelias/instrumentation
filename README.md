# Instrumentation

Monitor any process memory usage over time

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instrumentation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instrumentation

## Usage

### Command Line

To monitor a process, get its PID from the system (using `ps aux | grep PROCESS_NAME`) and start the command:

```
instrument <pid>
```

Then go to `http://localhost:8080` and you'll see the graph of memory usage over time.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## To do

Features to be done in order for the gem to be relased as `1.0`:

- [x] Auto-refresh report (fetch datapoints dynamically)
- [ ] Implement memory reader for Linux, that reads from `/proc/<pid>/statm`, example [here][linux-statm]
- [ ] Implement CPU % reader
- [ ] Implement Load average reader
- [ ] Let user customize HTTP server port via command line

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/felipeelias/instrumentation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[linux-statm]: https://gist.github.com/pvdb/6240788
