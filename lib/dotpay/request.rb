require 'digest'

module Dotpay
	class Request
		SIGNATURE_KEYS = %w(id amount currency description control url type buttontext urlc firstname surname email)

		attr_reader :params, :url

		def initialize(config, amount, description, firstname, surname, email, button_text, control, returning_url, confirmation_url = nil, type=0, currency="PLN")
			@params = {
				"id" => config.account_id,
				"amount" => ("%0.2f" % amount),
				"currency" => currency,
				"description" => description,
				"control" => control,
				"url" => returning_url,
				"firstname" => firstname,
				"surname" => surname,
				"email" => email,
				"buttontext" => button_text,
				"type" => type
			}

			params["urlc"] = confirmation_url unless confirmation_url.nil?

			@url = config.endpoint

			@params["chk"] = calculate_signature(config.pin)
		end

		private

		def calculate_signature(pin)
			data = [ pin ] + SIGNATURE_KEYS.map { |key| params[key] }
			data_string = data.join
			Digest::SHA256.hexdigest(data_string)
		end
  end
end
