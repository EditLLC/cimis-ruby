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

    def to_json
      Hash[attributes.map { |a| [a[0], a[1].to_f] }].to_json
    end
  end
end
