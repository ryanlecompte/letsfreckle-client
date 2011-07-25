require 'spec_helper'

describe LetsFreckle::Configuration do
  context "as DSL" do
    it "should properly set and read config values" do
      LetsFreckle.configure do
        username "user"
        account_host "userhost"
        token "secret"
      end

      LetsFreckle.config.username.should == "user"
      LetsFreckle.config.account_host.should == "userhost"
      LetsFreckle.config.token.should == "secret"
    end
  end
end