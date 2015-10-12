require 'spec_helper'
require 'net/http'
require 'uri'

describe 'Apache' do
  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe 'the Apache virtual host config' do
    describe file('/etc/apache2/sites-enabled/000-default.conf') do
      it { should_not be_symlink }
      it { should_not be_file }
    end

    describe file('/etc/apache2/sites-enabled/default-ssl.conf') do
      it { should_not be_symlink }
      it { should_not be_file }
    end

    describe file('/etc/apache2/sites-enabled/hello_world_vhost.conf') do
      it { should be_symlink }
    end
  end

  describe 'the hello world application' do
    let(:hello_world) { Net::HTTP.get(URI('http://localhost:80')) }

    it 'is served by Apache at the root path' do
      expect(hello_world.include? '<h1>Hello World!</h1>').to eq true
    end
  end
end
