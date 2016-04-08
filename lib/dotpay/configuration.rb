module Dotpay
  class Configuration
    # Account ID in Dotpay system, for which payment is made (Seller's account ID)
    attr_accessor :account_id

    # URLC PIN
    # 16-character alphanumeric string defined in section: Settings → URLC parameters
    attr_accessor :pin

    attr_accessor :test_mode

    # Language
    #
    # Defaults to :pl
    #
    # :pl → Polish
    # :en → English
    # :de → German
    # :it → Italian
    # :fr → French
    # :es → Spanish
    # :cz → Czech
    # :ru → Russian
    # :bg → Bulgarian
    attr_accessor :language

    # service hostname
    attr_accessor :endpoint

    # provider's email
    attr_accessor :email

    # Admin panel API endpoint
    attr_accessor :api_endpoint

    # Admin panel API login
    attr_accessor :api_login

    # Admin panel API password
    attr_accessor :api_password

    def initialize
      @test_mode = false
      @language = :pl
    end

    ##
    # Allows config options to be read like a hash
    #
    # option: Key for a given attribute
    def [](option)
      send(option)
    end

    def endpoint
      return @endpoint if @endpoint
      if test_mode
        "https://ssl.dotpay.pl/test_payment/"
      else
        "https://ssl.dotpay.pl/t2/"
      end
    end

    def api_endpoint
      return @api_endpoint if @api_endpoint
      if test_mode
        "https://ssl.dotpay.pl/test_seller/api/"
      else
        "https://ssl.dotpay.pl/s2/login/api/"
      end
    end
  end
end
