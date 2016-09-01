require 'test_helper'

module DNSimpler
  class HTTPTest < MiniTest::Test

    def setup
      super
      stub_request(:get, "#{DNSimpler.base_uri}registrar/domains/example.com/check").with(headers: {'Accept' => 'application/json', 'Authorization' => 'Bearer token-test-string', 'User-Agent' => "dnsimpler/#{DNSimpler::VERSION}"}).to_return(status: 404, body: { data: {"message"=>"Domain `example.com' not found"}}.to_json)
    end

    test "#base_options" do
      assert_instance_of Hash, HTTP.base_options
    end

    test "an error is raised for a failed request" do
      error = assert_raises ::DNSimpler::Error do
        HTTP.get("/registrar/domains/example.com/check")
      end

      refute (200...400).include? error.code
    end

    %w[get post head delete patch put].each do |method|
      class_eval <<-RUBY_EVAL

        test "#{method}" do
          response = HTTP.#{method}('/domains')
          assert_instance_of OpenStruct, response
        end

      RUBY_EVAL
    end
  end
end
