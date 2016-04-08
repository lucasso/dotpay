require 'spec_helper'

describe Dotpay do
  before :each do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
      config.api_login           = 'testlogin'
      config.api_password        = 'testpass'
    end
  end

  it "should have defaults" do
    Dotpay.configuration.endpoint.should == "https://ssl.dotpay.pl/t2/"
    Dotpay.configuration.api_endpoint.should == "https://ssl.dotpay.pl/s2/login/api/"
    Dotpay.configuration.language.should == :pl
  end

  describe "#configure" do
    it "should allow configuring" do
      Dotpay.configuration.account_id.should     == 1234
      Dotpay.configuration.pin.should            == 'testtesttesttest'
      Dotpay.configuration.api_login.should      == 'testlogin'
      Dotpay.configuration.api_password.should   == 'testpass'
    end
  end
end
