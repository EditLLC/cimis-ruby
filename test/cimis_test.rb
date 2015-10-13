require 'test_helper'

class CimisTest < Minitest::Test
  context ".configure" do
    should "accept an app_key" do
      Cimis.configure do |c|
        c.app_key = "foo"
      end

      assert_equal "foo", Cimis.app_key
    end

    should "raise an exception if no app key is given" do
      assert_raises(Cimis::MissingAttributeError, "You must include the app key") do
        Cimis.configure { |c| c.app_key = nil }
      end
    end
  end

  context "#camel_case_lower" do
    should "lower camel case the given string" do
      assert_equal "fooBar", Cimis.camel_case_lower("foo_bar")
    end      
  end

  context "#to_query" do
    should "transform a hash to a query string" do
      assert_equal "barFoo=2&fooBar=1", Cimis.to_query({foo_bar: 1, bar_foo: 2})  
    end
  end

  context "#underscore" do
    should "underscore a string" do
      assert_equal "foo_bar", Cimis.underscore("FooBar")
    end
  end

  context "#symbolize_keys" do
    should "symbolize the hash keys" do
      params = { "FooBar" => 1, "BarFoo" => 2 }
      expected = { foo_bar: 1, bar_foo: 2 }

      assert_equal expected, Cimis.symbolize_keys(params)
    end
  end
end
