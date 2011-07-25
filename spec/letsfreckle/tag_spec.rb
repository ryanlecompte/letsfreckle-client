require 'spec_helper'

describe LetsFreckle::Tag do
  context "#all" do
    it "should return all tags" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_http_request(:get, LetsFreckle::Tag.url('tags')).to_return(:body => load_response('tags'))
      tags = LetsFreckle::Tag.all
      tags.size.should == 2

      first_tag = tags.first
      first_tag.name.should == 'test tag 1'
    end
  end
end