require 'ostruct'
require "dnsimpler/version"
require 'dnsimpler/http'

module DNSimpler
  MATTRS = %w[username token base_uri debug]

  MATTRS.each do |mattr|
    module_eval <<-RUBY_EVAL, __FILE__, __LINE__
      def self.#{mattr}; return @@#{mattr}; end;
      def self.#{mattr}=(attr); @@#{mattr} = attr; end;
    RUBY_EVAL
  end

  # Debuggin is off by default
  @@debug = false

  # API username
  @@username = ''

  # API token
  @@token = ''

  # URI for the requests. Defaults to https://api.dnsimple.com/
  @@base_uri = 'https://api.dnsimple.com/'

  # http proxy info. Should be a hash {addr: 'http://example.com', port: 8080, user: 'bob', pass: 'ed'}
  @@http_proxy = nil

  def self.http_proxy=(opts)
    @@http_proxy = OpenStruct.new(opts)
  end

  def self.http_proxy
    @@http_proxy
  end

  # Allow configuring Dnsimpler with a block
  #
  # Example:
  #
  #     Dnsimpler.setup do |config|
  #       config.username = 'bob@example.com'
  #       config.token    = '1234'
  #       ....
  #     end
  def self.setup
    yield self
  end

  # Delegate the class methods to the HTTP class
  %w[get post head delete patch put].each do |method|
    module_eval <<-RUBY_EVAL, __FILE__, __LINE__

      def self.#{method}(path, options = {}, &blk)
        HTTP.#{method}(path, options, &blk)
      end

    RUBY_EVAL
  end

end
