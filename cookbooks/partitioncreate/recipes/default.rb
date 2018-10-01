#
# Cookbook:: partitioncreate
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#Including the require cookbook from Chef supermarket
include_recipe 'filesystem'

#Creating Partition vdb and mounting as data1
filesystem "data1" do
 fstype "ext4"
 device "/dev/vdb"
 mount "/data1"
 action [:create, :enable, :mount]
end

#Creating Particion vdc and mounting as data2
filesystem "data2" do
 fstype "ext4"
 device "/dev/vdc"
 mount "/data2"
 action [:create, :enable, :mount]
end
