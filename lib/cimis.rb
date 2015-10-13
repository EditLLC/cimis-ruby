require 'faraday'
require 'faraday_middleware'

require 'cimis/version'
require 'cimis/station'
require 'cimis/station_data'
require 'cimis/data_point'

module Cimis
  class MissingAttributeError < StandardError; end;

  class << self
    attr_accessor :app_key

    def configure
      yield self
      raise MissingAttributeError, "You must include the app key" unless app_key
    end

    def connection
      @connect ||= Faraday.new do |f|
        f.adapter :net_http
        f.url_prefix = "http://et.water.ca.gov/api"
        f.headers["User-Agent"] = "Cimis Ruby v#{Cimis::VERSION}"
        f.headers["Content-Type"] = "application/json"
        f.headers["Accept"] = "*/*"
        f.response :json, content_type: /\bjson$/
      end
    end

    def data(options = {})
      options.merge!({app_key: app_key})
      response = connection.get("data?#{to_query(options)}")
      response.body["Data"]["Providers"].first["Records"].map do |record|
        StationData.new(record)
      end
    end

    def to_query(params = {})
      params.collect do |key, value|
        "#{camel_case_lower(key.to_s)}=#{value}"
      end.sort * "&" 
    end

    def camel_case_lower(str)
      str.split('_').inject([]) do |buffer,e| 
        buffer.push(buffer.empty? ? e : e.capitalize)
      end.join
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
  end
end
