require 'virtus'

module Cimis
  class DataPoint
    include Virtus.model

    attribute :value, Float, default: 0
    attribute :qc, String
    attribute :unit, String

    def initialize(params)
      super(Cimis.symbolize_keys(params)) 
    end

    def to_h
      Hash[
        attributes.map do |a| 
          key = a[0]
          value = a[0] == :value ? a[1].to_f : a[1]
          [key, value]
        end
      ]
    end
  end
end
