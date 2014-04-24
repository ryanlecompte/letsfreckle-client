require 'spec_helper'

describe LetsFreckle::Project do
  context "#all" do
    it "should return all projects" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_api_request('projects')
      projects = LetsFreckle::Project.all
      projects.size.should == 2

      first_project = projects.first
      first_project.name.should == 'TestProject1'
    end
  end

  context ".find" do
    it "should return one project" do
      LetsFreckle.configure do
        username "username"
        account_host "host"
        token "secret"
      end

      stub_api_request('projects/1343')
      project = LetsFreckle::Project.find(1343)
      project.class.should == LetsFreckle::Project

      project.name.should == 'TestProject1'
    end

    describe "with cached tags" do
      before :each do
        LetsFreckle.configure do
          username "username"
          account_host "host"
          token "secret"
        end
        stub_api_request('projects/1344')
      end

      it "should return one project" do
        project = LetsFreckle::Project.find(1344)
        project.class.should == LetsFreckle::Project
        project.name.should == 'TestProject2'
      end

      it "should have two cached tags" do
        project = LetsFreckle::Project.find(1344)
        expected_cached_tags = [
          { "tag" => { "billable" => "t", "name" => "billabletag", "id" => 13431 } },
          { "tag" => { "billable" => "n", "name" => "nonbillabletag", "id" => 13432 } }
        ]
        project.cached_tags.should == expected_cached_tags
      end
    end
  end
end
