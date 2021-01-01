# Minisplit ![Build](https://github.com/joshpencheon/minisplit/workflows/Ruby/badge.svg)  [![Gem Version](https://badge.fury.io/rb/minisplit.svg)](https://badge.fury.io/rb/minisplit)

Really Simple Splitting of your minitest suite.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minisplit'
```

In your `test_helper.rb`, add:

```ruby
# test/test_helper.rb
require 'minisplit/setup'
```

## Usage

By default, Minisplit won't affect your test suite in any way.

However, by setting two environment variables, you can split your test suite into partitions that you can run in parallel:

```bash
# Run the first of four partitions:
$ MINISPLIT_INDEX=0 MINISPLIT_TOTAL=4 bundle exec rake

# Run the second of four partitions:
$ MINISPLIT_INDEX=1 MINISPLIT_TOTAL=4 bundle exec rake
```

### CI

The most likely usecase for Minisplit is to quickly speed up CI builds, without any other supporting infrastructure / services.

For example, GitHub Actions configuration:

```yaml
test:
  strategy:
    matrix:
      minisplit_index: [0, 1, 2, 3]

  steps:
  - name: Run tests
    run: bundle exec rake
    env:
      MINISPLIT_INDEX: ${{ matrix.minisplit_index }}
      MINISPLIT_TOTAL: 4

```

## Things to Note

* There is no queue-based assigning; a deterministic partitioning of all examples is done. This isn't going to give an optimal use of time, but for larger suites with higher parallelism, it should be good enough.
* This can work alongside Minitest's parallel executor, and Rails' parallel tests. So multi-core CI nodes can still be exploited.
* Because examples in other partitions are silently skipped, all partitions will report the same number (the total number) of runs. Assertions will be counted correctly.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshpencheon/minisplit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joshpencheon/minisplit/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Minisplit project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joshpencheon/minisplit/blob/master/CODE_OF_CONDUCT.md).
