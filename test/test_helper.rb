require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "minitest/autorun"
require 'dnsimpler'
require 'webmock/minitest'

class MiniTest::Test

  def setup
    DNSimpler.setup do |config|
      config.base_uri = "https://api.sandbox.dnsimple.com/"
      config.token = "token-test-string"
      config.http_proxy = nil
      config.debug = false
    end

    WebMock.disable_net_connect!(allow: "codeclimate.com")
    stub_request(:any, "#{DNSimpler.base_uri}domains").with(headers: {'Accept' => 'application/json', 'Authorization' => 'Bearer token-test-string', 'User-Agent' => "dnsimpler/#{DNSimpler::VERSION}"}).to_return(status: 200, body: {data: [{domain: {id: 707}}, {domain: {id: 708}}]}.to_json)
  end

  # Stolen from rails source cause I like the syntax
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = method_defined? test_name
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end

end
