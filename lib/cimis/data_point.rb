require 'virtus'

module Cimis
  class DataPoint
    include Virtus.model

    attribute :value, Float
    attribute :qc, String
    attribute :unit, String

    def initialize(params)
      super(Cimis.symbolize_keys(params)) 
    end
  end
end
