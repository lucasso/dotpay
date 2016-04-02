require 'spec_helper'

describe Dotpay::Response do
  before :each do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
    end
  end

  describe "#authorized?" do
    let(:params) do
      { "status"=>"FAIL",
        "control"=>"5DA5L8F5",
        "operation_original_amount"=>"1.00",
        "id"=>"66548",
        "transaction_id"=>"66548-TST55",
        "t_id"=>"66548-TST55",
        "t_date"=>"2013-02-13 16:23:43",
        "o_id"=>"66548-ZTST55",
        "email"=>"test@email.com",
        "t_status"=>"3",
        "description"=>"Uzsakymo 5DA5L8F5 apmokejimas",
        "version"=>"1.4",
        "orginal_amount"=>"1.00 PLN",
        "channel"=>"20",
        "signature"=>"906a581afc516b4c717dbb301c7bd013af4e5d220ca68b1cb355a2d7aef04aa0"}
    end

    let(:response) { Dotpay::Response.new(params) }

    subject { response.authorized? }

    it { should be_truthy }

    context "invalid pin" do
      before { Dotpay.configuration.stub(:pin).and_return('badpin') }
      it { should be_falsy }
    end
  end
end
