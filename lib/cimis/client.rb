require 'faraday'
require 'faraday_middleware'
require 'json'
require 'cimis/station'

module Cimis
  class Client
    attr_accessor :app_key

    def initialize
      yield(self) if block_given?
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

    def get_sites
      response = connection.get("station")
      response.body["Stations"].map do |station|
        Cimis::Station.new(station)
      end
    end
  end
end
