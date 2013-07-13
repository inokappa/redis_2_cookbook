require 'spec_helper'

describe file('/usr/local/bin/redis-server') do
  it { should be_executable }
end

describe file('/usr/local/bin/redis-cli') do
  it { should be_executable }
end

describe file('/usr/local/redis') do
  it { should be_executable }
end

describe file('/etc/init.d/redis-server') do
  it { should be_file }
  it { should be_executable }
end

describe service('redis-server') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(6379) do
  it { should be_listening }
end

describe file('/usr/local/etc/redis.conf') do
  it { should be_file }
  it { should contain "daemonize yes" }
  it { should contain "dir /usr/local/redis" }
end

describe user('redis-user') do
  it { should exist }
  it { should belong_to_group 'redis-user' }
  it { should have_login_shell '/bin/false' }
end
