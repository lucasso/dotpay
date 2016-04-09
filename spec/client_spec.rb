require 'spec_helper'

describe Dotpay::Client do
  before do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
      config.api_login           = 'testlogin'
      config.api_password        = 'testpass'
    end
  end

  describe "#refund_payment" do
    subject { Dotpay.client.refund_payment("M1279-3810", "TX01", 1.00, "DESCRIPTION") }

    context "successful" do
      before do
        stub_request(:post, "https://testlogin:testpass@ssl.dotpay.pl/s2/login/api/payments/M1279-3810/refund/")
          .with(body: {
            "control"     => "TX01",
            "amount"      => "1.00",
            "description" => "DESCRIPTION",
          }).to_return({
            status: 200,
            body: '{ "detail": "ok" }'
          })
      end

      it { should be_truthy }
    end

    context "error" do
      before do
        stub_request(:post, "https://testlogin:testpass@ssl.dotpay.pl/s2/login/api/payments/M1279-3810/refund/")
          .with(body: {
            "control"     => "TX01",
            "amount"      => "1.00",
            "description" => "DESCRIPTION",
          }).to_return({
            status: 404
          })
      end

      specify do
        expect { subject }.to raise_error(Dotpay::Error)
      end
    end
  end
end
