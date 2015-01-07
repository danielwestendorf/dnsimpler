require 'test_helper'

class DNSimplerTest < MiniTest::Test
  CONFIGS = %w[username token base_uri debug]

  CONFIGS.each do |config|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__
      test "##{config}" do
        refute_nil DNSimpler.#{config}
      end

      test "##{config}=" do
        refute_nil DNSimpler.#{config}= 'test-string'
      end

      test "##{config}= in setup block" do
        DNSimpler.setup do |config|
          config.#{config} = "#{config}-test-string"
        end

        assert DNSimpler.#{config}, "#{config}-test-string"
      end
    RUBY_EVAL
  end

  %w[get post head delete patch put].each do |method|
    class_eval <<-RUBY_EVAL

    test "#{method}" do
      response = DNSimpler.#{method}('v1/domains')
      assert_instance_of OpenStruct, response
    end

    RUBY_EVAL
  end

  test "invalid config variable" do
    assert_raises NoMethodError do
      DNSimpler.nonconfig = 'bob'
    end

    assert_raises NoMethodError do
      DNSimpler.setup do |config|
        config.fake = 'ed'
      end
    end
  end

  test "#{}http_proxy" do
    DNSimpler.http_proxy = {addr: 'http://example.com', port: 8080, user: 'bob', pass: 'password'}
    assert_instance_of OpenStruct, DNSimpler.http_proxy
  end

end