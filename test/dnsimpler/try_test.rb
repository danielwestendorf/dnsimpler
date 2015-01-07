require 'test_helper'

class TryTest < MiniTest::Test

  test "Hash responds to try" do
    assert_respond_to Hash.new, :try
  end

  test "NilClass responds to try" do
    assert_respond_to nil, :try
  end

end
