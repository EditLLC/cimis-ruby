require 'virtus'

module Cimis
  class Station
    include Virtus.model

    attribute :station_nbr, Integer
    attribute :name, String
    attribute :city, String
    attribute :regional_office, String
    attribute :county, String
    attribute :connect_date, DateTime
    attribute :disconnect_date, DateTime
    attribute :is_active, Boolean
    attribute :is_eto_station, Boolean
    attribute :elevation, Integer
    attribute :ground_cover, String
    attribute :hms_latitude, Float
    attribute :hms_longitude, Float
    attribute :zip_codes, Array[String]

    def initialize(params)
      processed_params = process_params(params)
      super(processed_params)
    end

    def self.all
      response = Cimis.connection.get("station")
      response.body["Stations"].map do |station|
        new(station)
      end
    end

    def process_params(params)
      symbolized = Cimis.symbolize_keys(params)
      symbolized[:hms_latitude] = extract_coordinate(symbolized[:hms_latitude])
      symbolized[:hms_longitude] = extract_coordinate(symbolized[:hms_longitude])
      symbolized[:connect_date] = parse_date(symbolized[:connect_date])
      symbolized[:disconnect_date] = parse_date(symbolized[:disconnect_date])
      symbolized
    end

    def extract_coordinate(str)
      word = str.dup
      word = word.split("/").last
      word.strip!
    end

    def parse_date(date_str)
      DateTime.strptime(date_str, "%m/%d/%Y")
    end

    def hourly_options
      %w(
        hly-air-tmp
        hly-dew-pnt
        hly-eto
        hly-net-rad
        hly-asce-eto
        hly-asce-etr
        hly-precip
        hly-rel-hum
        hly-res-wind
        hly-soil-tmp
        hly-sol-rad
        hly-vap-pres
        hly-wind-dir
        hly-wind-spd
      ).join(',')
    end

    def data(options = {})
      options.merge!(dataItems: hourly_options) if options.delete(:hourly)
      options.merge!({app_key: Cimis.app_key, targets: station_nbr})
      response = Cimis.connection.get("data?#{Cimis.to_query(options)}")
      response.body["Data"]["Providers"].first["Records"].map do |record|
        StationData.new(record)
      end
    end
  end
end
