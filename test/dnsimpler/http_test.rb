require 'test_helper'

module DNSimpler
  class HTTPTest < MiniTest::Test

    test "#base_options" do
      assert_instance_of Hash, HTTP.base_options
    end

    %w[get post head delete patch put].each do |method|
      class_eval <<-RUBY_EVAL

        test "#{method}" do
          response = HTTP.#{method}('v1/domains')
          assert_instance_of OpenStruct, response
        end

      RUBY_EVAL
    end
  end
end