require 'faraday'
require 'oga'
require 'json'
require 'net/http'

module Fabricate
  class Fabricate
    attr_reader :app_identifier
    attr_reader :api_key
    attr_reader :filename
    attr_reader :developer_token
    attr_accessor :verbose

    def initialize(options)
      @app_identifier = options[:app_identifier]
      @api_key = options[:api_key]
      @filename = options[:filename]
    end
    
    def run!
      debug "Getting CSRF token..."
      response = Faraday.get "https://fabric.io/login"
      document = Oga.parse_html(response.body)
      csrf_token = document.at_css('meta[name="csrf-token"]')['content']
      raise "No CSRF token!" if csrf_token.nil?
      debug "CSRF token: #{csrf_token}"
      
      debug "Getting developer token..."
      response = Faraday.get "https://fabric.io/api/v2/client_boot/config_data" do |req|
        req.headers['X-CSRF-Token'] = csrf_token
      end
      developer_token = JSON.parse!(response.body)['developer_token']
      debug "Developer token: #{developer_token}"
      raise "No developer token!" if developer_token.nil?
      @developer_token = developer_token

      debug "Uploading file..."
      upload_file!
    end

    def upload_file!
      conn = Faraday.new do |conn|
        conn.request :multipart
        conn.request :url_encoded
        # Last middleware must be the adapter:
        conn.adapter :net_http
      end

      payload = Hash.new
      payload['code_mapping[file]'] = Faraday::UploadIO.new(filename, 'application/zip')
      payload['code_mapping[type]'] = 'dsym'
      payload['project[identifier]'] = app_identifier

      response = conn.post "https://cm.crashlytics.com/api/v3/platforms/ios/code_mappings", payload do |req|
        req.headers['X-CRASHLYTICS-API-KEY'] = api_key
        req.headers['X-CRASHLYTICS-DEVELOPER-TOKEN'] = developer_token
      end
      debug "Status: #{response.status}"
      debug response.body
    
    end

    def debug(message)
      STDERR.puts message if verbose
    end

    def print(message)
      STDERR.puts message
    end

    def output(message)
      puts message
    end
  end
end