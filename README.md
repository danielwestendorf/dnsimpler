# Dnsimpler
[![TravisCI](https://travis-ci.org/danielwestendorf/dnsimpler.svg)](https://travis-ci.org/danielwestendorf/dnsimpler)[![Code Climate](https://codeclimate.com/github/danielwestendorf/dnsimpler/badges/gpa.svg)](https://codeclimate.com/github/danielwestendorf/dnsimpler)[![Test Coverage](https://codeclimate.com/github/danielwestendorf/dnsimpler/badges/coverage.svg)](https://codeclimate.com/github/danielwestendorf/dnsimpler)

A simple API wrapper for [DNSimple](https://dnsimple.com). Always returns the full response. Requires you to use the [API documentation](https://developer.dnsimple.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dnsimpler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dnsimpler

## Usage

Configure the gem
```ruby
DNSimpler.setup do |config|
    config.username = "bob@example.com"
    config.token = "DNSIMPLE_API_TOKEN"
    config.base_uri = "https://api.dnsimple.com" # For testing you can use the sandbox
    config.debug = false
    config.proxy = {addr: 'http://example.com', port: 8080, user: 'bob', pass: 'password'}
end
```

Make your API calls.
```ruby
domains_response = DNSimpler.get('v1/domains')
p domains_response.code
=> 200
p domains_response.body
[ { domain: { ... } }, { domain: { ... } } ]
```

Some API calls require parameters. Just pass them as a hash
```ruby
registration = DNSimpler.post('v1/domain_registrations', domain: {name: 'example.com', registrant_id: 1234})
p registration.code
=> 201
p domains_response.body
{ domain: { name: 'example.com', .... } }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dnsimpler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
