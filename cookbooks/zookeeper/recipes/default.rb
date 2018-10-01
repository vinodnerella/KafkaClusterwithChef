#
# Cookbook:: zookeeper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


include_recipe 'tar'

#Creating user for zookeeper
user "zookeeper" do
 password 'USERPASSWORD'
end

#Creating and updating directory permissions
directory '/opt/zookeeper' do
  owner 'zookeeper'
  group 'zookeeper'
  mode '0755'
  action :create
  recursive true
end

#Downloading and extracting the zookeeper

tar_extract 'http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz' do
  target_dir '/opt/zookeeper'
  creates '/opt/zookeeper/conf'
  tar_flags [ '-P', '--strip-components 1' ]
end

#Changing the permissions for extracted files

execute 'chown-zookeeper' do
  command "chown -R zookeeper:zookeeper /opt/zookeeper"
  action :run
end

#Updating the zookeeper configuaration files
template '/opt/zookeeper/conf/log4j.properties' do
  source 'log4j.properties.erb'
end

template '/opt/zookeeper/conf/zoo.cfg' do
  owner 'zookeeper'
  group 'zookeeper'
  mode '0644'
  source 'zoo.cfg.erb'
end

#Updating /etc/hosts
template '/etc/hosts' do
  source 'hosts.erb'
end

#Creating Data Directory
directory '/var/lib/zookeeper' do
  owner 'zookeeper'
  group 'zookeeper'
  mode '0755'
  action :create
  recursive true
end

#Creating Log directory
directory '/var/log/zookeeper' do
  owner 'zookeeper'
  group 'zookeeper'
  mode '0755'
  action :create
end
