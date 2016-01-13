require 'virtus'
require 'cimis/data_point'

module Cimis
  class StationData
    include Virtus.model

    attribute :julian, Integer, default: 0
    attribute :hour, Integer
    attribute :station, Integer, default: 0
    attribute :standard, String
    attribute :zip_codes, Array[String]
    attribute :scope, String

    # Daily Data Points
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

    # Hourly Data Points
    attribute :hly_air_tmp, Cimis::DataPoint
    attribute :hly_dew_pnt, Cimis::DataPoint
    attribute :hly_eto, Cimis::DataPoint
    attribute :hly_net_rad, Cimis::DataPoint
    attribute :hly_asce_eto, Cimis::DataPoint
    attribute :hly_asce_etr, Cimis::DataPoint
    attribute :hly_precip, Cimis::DataPoint
    attribute :hly_rel_hum, Cimis::DataPoint
    attribute :hly_res_wind, Cimis::DataPoint
    attribute :hly_soil_temp, Cimis::DataPoint
    attribute :hly_sol_rad, Cimis::DataPoint
    attribute :hly_vap_pres, Cimis::DataPoint
    attribute :hly_wind_dir, Cimis::DataPoint
    attribute :hly_wind_spd, Cimis::DataPoint

    def initialize(params)
      super(Cimis.symbolize_keys(params))
    end
  end
end
