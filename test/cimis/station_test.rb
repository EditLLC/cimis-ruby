require 'test_helper'

module Cimis
  class StationTest < Minitest::Test
    def setup
      @valid_params = {
        "HmsLatitude" => "6º48'52N / 36.814444",
        "HmsLongitude" => "-119º43'54W / -119.731670",
        "ConnectDate" => "6/7/1982",
        "DisconnectDate" => "9/25/1988"
      }
      @station = Station.new(@valid_params)
    end

    context "#underscore" do
      should "underscore a string" do
        assert_equal "foo_bar", @station.underscore("FooBar")
      end
    end

    context "#symbolize_keys" do
      should "symbolize the hash keys" do
        params = { "FooBar" => 1, "BarFoo" => 2 }
        expected = { foo_bar: 1, bar_foo: 2 }

        assert_equal expected, @station.symbolize_keys(params)
      end
    end

    context "#extract_coordinate" do
      should "extract the coordinate from the string" do
        assert_equal "36.814444", @station.extract_coordinate("6º48'52N / 36.814444")
      end
    end

    context "#parse_date" do
      should "parse the date" do
        assert_equal DateTime.strptime("5/4/2015", "%m/%d/%Y"), @station.parse_date("5/4/2015")
      end
    end

    context "#process_params" do
      should "process the params" do
        expected = {
          hms_latitude: "36.814444",
          hms_longitude: "-119.731670",
          connect_date: @station.parse_date("6/7/1982"),
          disconnect_date: @station.parse_date("9/25/1988")
        }

        assert_equal expected, @station.process_params(@valid_params)
      end
    end
  end
end
