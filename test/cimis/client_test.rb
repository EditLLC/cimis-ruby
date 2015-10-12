require 'test_helper'

module Cimis
  class ClientTest < Minitest::Test
    context "initialize" do
      should "accept an app_key" do
        client = Cimis::Client.new do |c|
          c.app_key = "foo"
        end

        assert_equal "foo", client.app_key
      end
    end
  end
end
