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

    it "should return all entries on all pages" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_api_request('entries', {:page => 1})
      stub_api_request('entries', {:page => 2})
      stub_api_request('entries', {:page => 3})
      entries = LetsFreckle::Entry.all(:all_pages => true)
      entries.size.should == 4
    end
  end

  context "by_page" do
    it "should return the specific page" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_api_request('entries', {:page => 3})
      entries = LetsFreckle::Entry.find(:page => 3)
      entries.size.should == 0
    end
  end
end
