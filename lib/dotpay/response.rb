require 'digest'

module Dotpay
  class Response
    SIGNATURE_KEYS = %w(
      id
      operation_number
      operation_type
      operation_status
      operation_amount
      operation_currency
      operation_withdrawal_amount
      operation_commission_amount
      operation_original_amount
      operation_original_currency
      operation_datetime
      operation_related_number
      control
      description
      email
      p_info
      p_email
      channel
      channel_country
      geoip_country
    )

    attr_reader :params

    def initialize(config, params)
      @params = params
      @pin = config.pin
    end

    def authorized?
      @params['signature'] == calculate_signature
    end

    private

    def calculate_signature
      data = [ @pin ] + SIGNATURE_KEYS.map { |key| @params[key] }
      data_string = data.join
      Digest::SHA256.hexdigest(data_string)
    end
  end
end
