require 'uri'
require 'net/http'
require 'net/https'

module Dotpay
  class Client
    def initialize(configuration)
      @configuration = configuration
    end

    def refund_payment(operation_number, control, amount, description)
      amount = "%0.2f" % amount

      url = @configuration.api_endpoint + "payments/#{operation_number}/refund/"
      params = {
        "control" => control,
        "amount" => amount,
        "description" => description
      }

      response = post(url, params)
      raise Error.new(response.body) if response.code != "200"
      true
    end

    private

    def post(url, params)
      uri = URI.parse(url)

      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      request.basic_auth(@configuration.api_login, @configuration.api_password)

      https.request(request)
    end
  end
end
