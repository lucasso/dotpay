module Dotpay
  class Error < ::StandardError
    attr_reader :response, :code, :message

    def initialize(response)
      @response = response
      @code = response.code.to_i
      super(@message = response.body.to_s)
    end
  end
end
