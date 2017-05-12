require 'uri'
require 'net/http'
require 'net/https'

module Dotpay
  class Client
    def initialize(configuration)
      @configuration = configuration
    end

    def get_payment(operation_number)
      url = @configuration.api_endpoint + "payments/#{operation_number}/"
      get(url)
    end

    def get_operation(operation_number)
      url = @configuration.api_endpoint + "operations/#{operation_number}/"
      get(url)
    end

    def get_operation_operations(operation_number)
      url = @configuration.api_endpoint + "operations/#{operation_number}/operations/"
      get(url)
    end

    def refund_payment(operation_number, control, amount, description)
      amount = "%0.2f" % amount

      url = @configuration.api_endpoint + "payments/#{operation_number}/refund/"
      params = {
        "control" => control,
        "amount" => amount,
        "description" => description
      }

      post(url, params)
    end

    def get(url)
      uri = URI.parse(url)

      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri, "Content-Type" => "application/json")
      request.basic_auth(@configuration.api_login, @configuration.api_password)

      response = https.request(request)
      raise Error.new(response) if response.code != "200"
      response
    end

    def post(url, params)
      uri = URI.parse(url)

      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json")
      request.basic_auth(@configuration.api_login, @configuration.api_password)
      request.body = params.to_json

      response = https.request(request)
      raise Error.new(response) if response.code != "200"
      response
    end
  end
end
