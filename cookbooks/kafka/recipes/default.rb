#
# Cookbook:: kafka
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'tar'

#Cretaing user
user 'kafka' do
 password "USERPASSWORD"
end

#Downoading package
tar_extract "http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.11-2.0.0.tgz" do target_dir "/opt/kafka"
 creates "/opt/kafka/config"
 tar_flags ['-P', '--strip-components 1']
end

#Updating Permissions
execute 'chown-kakfa' do
 command "chown -R kafka:kafka /opt/kafka"
 action :run
end

#Updating server.properties
template '/opt/kafka/config/server.properties' do
 source 'server.properties.erb'
end

#Updating /etc/hosts

template '/etc/hosts' do
 source 'hosts.erb'
end

#Creating log directories

directory '/var/log/kafka-logs' do
 owner 'kafka'
 group 'kafka'
 mode '0755'
 action :create
 recursive true
end
