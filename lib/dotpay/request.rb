require 'digest'

module Dotpay
	class Request
		SIGNATURE_KEYS = %w(id amount currency description url type urlc)

		attr_reader :params, :url

		def initialize(config, amount, description, returning_url, confirmation_url = nil, type=4, currency="PLN")
			@params = {
				"id" => config.account_id,
				"amount" => ("%0.2f" % amount),
				"currency" => currency,
				"description" => description,
				"url" => returning_url,
				"type" => type
			}

			params["urlc"] = confirmation_url unless confirmation_url.nil?

			@url = config.endpoint

			@params["chk"] = calculate_signature
		end

		private

		def calculate_signature
			data = [ Dotpay.configuration.pin ] + SIGNATURE_KEYS.map { |key| params[key] }
			data_string = data.join
			Digest::SHA256.hexdigest(data_string)
		end
  end
end
