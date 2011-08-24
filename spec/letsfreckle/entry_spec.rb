require 'spec_helper'

describe LetsFreckle::Entry do
  context "#all" do
    it "should return all entries" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_api_request('entries')
      entries = LetsFreckle::Entry.all
      entries.size.should == 2

      first_entry = entries.first
      first_entry.description.should == 'api test description'
    end
  end
end