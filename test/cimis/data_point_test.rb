require 'test_helper'

module Cimis
  class DataPointTest < Minitest::Test
    context "#to_h" do
      should "zero out nil values" do
        d = DataPoint.new({"value" => "null", "qc" =>  "", "unit" => ""})
        expected = {
          value: 0.0,
          qc: "",
          unit: ""
        }

        assert_equal expected, d.to_h
      end
    end
  end
end
