require "spec_helper"

describe "image ruby 21" do
  before (:all) do
    @image = Docker::Image.all.detect do |image|
      image.info['RepoTags'].include? "jacoelho/baseimage-ruby21:latest"
    end
    set :docker_image, "jacoelho/baseimage-ruby21:latest"
  end

  it "should exist" do
    expect(@image).not_to be_nil
  end

  describe selinux do
    it { should be_disabled }
  end

  packages = %w(bash nginx-common nginx-extras ruby2.1 ruby2.1-dev redis-server redis-tools memcached)
  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  describe package('bundler') do
    it { should be_installed.by('gem') }
  end

  describe file('/var/www/service/current') do
      it { should be_owned_by 'app' }
  end
end
