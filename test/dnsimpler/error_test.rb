require 'test_helper'

class DNSimpler::ErrorTest < MiniTest::Test

  test "initialize" do
    assert_raises DNSimpler::Error do
      raise DNSimpler::Error.new(200, {body: 'blah'}, nil)
    end
  end

  %w[code body response].each do |attr|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__

      test "##{attr}" do
        error = DNSimpler::Error.new(200, {body: 'blah'}, true)
        refute_nil error.#{attr}
      end

    RUBY_EVAL
  end

end
