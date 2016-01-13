# Cimis Ruby

This is a slim wrapper around the Department of Water Resources CIMIS REST API.
It allows you to easily query the API and get easy to handle responses.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cimis-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cimis-ruby

## Usage

### Setup
The first thing you need to do is setup your app key. If you haven't yet
registered, go to the [CIMIS website](http://wwwcimis.water.ca.gov/) and
register. You can then go to your account page and retrieve the app key.

You need to configure the wrapper to use your app key:
```ruby
Cimis.configure { |c| c.app_key = <your_app_key> }
```

### Stations

Get a list of CIMIS stations:
```ruby
Cimis::Station.all
```

This will return an array of station objects. Each station can then be used
to query for data from that station on the object itself:
```ruby
station = Cimis::Station.all.first
station.data(start_date: "2015-10-10", end_date: "2015-10-12")
```

This will return daily stats by default, if you would instead like to get
hourly stats, just add the hourly option:
```ruby
station.data(start_date: "2015-10-10", end_date: "2015-10-12", hourly: true)
```

### General Querying

Aside from getting data for a station, you can also query the api using a
variety of location targets (lat, lng, zip, address). See the
[CIMIS API reference](http://et.water.ca.gov/Rest/Index) for more details.
```ruby
Cimis.data(
  targets: "lat=34.99,lng=-119.34",
  start_date: "2015-10-10",
  end_date: "2015-10-12"
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake test` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/cimis-ruby. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

