#
# Cookbook Name:: redis_2_cookbook
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%W{gcc make}.each do |pkgs|
  package pkgs do
    action :install
  end
end
