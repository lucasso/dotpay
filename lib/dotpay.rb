require "dotpay/version"
require "dotpay/configuration"
require "dotpay/error"
require "dotpay/response"
require "dotpay/client"

module Dotpay
  class << self
    attr_writer :configuration

    ##
    # Used to configure Dotpay.
    #
    # = Example
    #
    #   Dotpay.configure do |config|
    #     config.account_id            = 0000
    #     config.pin                   = 'aaaabbbbccccdddd'
    #     config.api_login          = 'cancelapilogin'
    #     config.api_password       = 'cancelapipassword'
    #   end
    def configure
      yield(configuration)
    end

    ##
    # The configuration object.
    # Recommended to use Dotpay.configure
    def configuration
      @configuration ||= Configuration.new
    end

    ##
    # Dotpay Client.
    def client
      @client ||= Client.new(configuration)
    end
  end
end
