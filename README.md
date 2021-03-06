# Instrumentation

[![Build Status](https://travis-ci.org/felipeelias/instrumentation.svg?branch=master)](https://travis-ci.org/felipeelias/instrumentation)
[![Gem Version](https://badge.fury.io/rb/erb-view.svg)](https://badge.fury.io/rb/erb-view)
[![Maintainability](https://api.codeclimate.com/v1/badges/6531f22fba0af4aa09be/maintainability)](https://codeclimate.com/github/felipeelias/instrumentation/maintainability)

Monitor any system stats and process memory usage over time.

![Example](https://github.com/felipeelias/instrumentation/blob/4d74af4a8ad0c97cc2940dec92399e54dbfd4d5e/example.gif "Example")

## Installation

```
gem install process-instrumentation
```

## Usage

To monitor a process, get its PID from the system (using `ps aux | grep PROCESS_NAME`) and start the command:

```
$ instrument <pid>
```

Then go to `http://localhost:8080` and you'll see the graph of memory usage over time.

## Development/Testing

Install dependencies with:

```
bin/setup
```

Run tests with:

```
rake test
```

Run the local binary with:

```
exe/instrument <pid>
```

An interactive console with all files loaded is available on:

```
bin/console
```

## Documentation

You can generate documentation locally:

```
rake yard
```

Then open `doc/index.html` in your browser.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/felipeelias/instrumentation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Make sure that the code passes the style guidelines with:

```
rake rubocop
```

If you want to contribute with anything but don't know where to start, check the project's to-do list:

- [x] Auto-refresh report (fetch datapoints dynamically)
- [x] Implement Load average reader
- [x] Setup rubocop task
- [ ] Implement option parser for command line tool
- [ ] Add tests when the interface and functionality is defined
- [ ] Implement memory reader for Linux, that reads from `/proc/<pid>/statm`, example [here][linux-statm]
- [ ] Implement CPU % reader
- [ ] Let user customize HTTP server port via command line
- [ ] Setup continuous integration
- [ ] Setup code climate

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[linux-statm]: https://gist.github.com/pvdb/6240788
