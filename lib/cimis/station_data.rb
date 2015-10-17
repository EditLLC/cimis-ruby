require 'virtus'
require 'cimis/data_point'

module Cimis
  class StationData
    include Virtus.model

    attribute :julian, Integer, default: 0
    attribute :station, Integer, default: 0
    attribute :standard, String
    attribute :zip_codes, Array[String]
    attribute :scope, String
    attribute :day_air_tmp_avg, Cimis::DataPoint
    attribute :day_air_tmp_max, Cimis::DataPoint
    attribute :day_air_tmp_min, Cimis::DataPoint
    attribute :day_dew_pnt, Cimis::DataPoint
    attribute :day_asce_eto, Cimis::DataPoint
    attribute :day_precip, Cimis::DataPoint
    attribute :day_rel_hum_avg, Cimis::DataPoint
    attribute :day_rel_hum_max, Cimis::DataPoint
    attribute :day_rel_hum_min, Cimis::DataPoint
    attribute :day_soil_tmp_avg, Cimis::DataPoint
    attribute :day_sol_rad_avg, Cimis::DataPoint
    attribute :day_vap_pres_avg, Cimis::DataPoint
    attribute :day_wind_run, Cimis::DataPoint
    attribute :day_wind_spd_avg, Cimis::DataPoint

    def initialize(params)
      super(Cimis.symbolize_keys(params))    
    end
  end
end
