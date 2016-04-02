require 'spec_helper'

describe Dotpay::CancelRequest do
  before :each do
    Dotpay.configure do |config|
      config.account_id             = 1234
      config.pin                    = 'testtesttesttest'
      config.cancel_login           = 'testlogin'
      config.cancel_password        = 'testpass'
    end
  end

  describe ".new" do
    let(:t_id) { "TST01" }
    let(:amount) { "1.00" }
    let(:control) { "ABCD" }

    subject { Dotpay::CancelRequest.new(t_id, amount, control) }

    it "#t_id returns valid value" do
      subject.t_id.should == t_id
    end

    it "#amount returns valid value" do
      subject.amount.should == amount
    end

    it "#control returns valid value" do
      subject.control.should == control
    end

    it "#type returns valid value" do
      subject.type.should == Dotpay::CancelRequest::TYPE_FULL
    end

    it "#checksum returns valid value" do
      subject.checksum.should == "5f6b85d31fa19ee60db2e2bcc9c595f6"
    end

  end
end
