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

    def process_params(params)
      symbolized = symbolize_keys(params)
      symbolized[:hms_latitude] = extract_coordinate(symbolized[:hms_latitude])
      symbolized[:hms_longitude] = extract_coordinate(symbolized[:hms_longitude])
      symbolized[:connect_date] = parse_date(symbolized[:connect_date])
      symbolized[:disconnect_date] = parse_date(symbolized[:disconnect_date]) 
      symbolized
    end

    def underscore(str)
      word = str.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end

    def symbolize_keys(params)
      {}.tap do |hsh|
        params.keys.each { |k| hsh[underscore(k).to_sym] = params[k] }
      end
    end

    def extract_coordinate(str)
      word = str.dup
      word = word.split("/").last
      word.strip!
    end

    def parse_date(date_str)
      DateTime.strptime(date_str, "%m/%d/%Y")
    end
  end
end
