require 'pathname'
require 'chef/mixin/shell_out'

module FilesystemMod
  include Chef::Mixin::ShellOut

  MOUNT_EX_FAIL = 32 unless const_defined?(:MOUNT_EX_FAIL)
  NET_FS_TYPES = %w(nfs cifs smp nbd).freeze unless const_defined?(:NET_FS_TYPES)

  # Check to determine if the device is mounted.
  def mounted?(device)
    mounted = shell_out("grep -q '#{device}' /proc/mounts").exitstatus != 0 ? nil : shell_out("grep -q '#{device}' /proc/mounts").exitstatus
    mounted
  end

  # Check to determine if the mount is frozen.
  def filesystem_frozen?(mount_loc)
    fields = File.readlines('/proc/mounts').map(&:split).detect { |field| field[1] == mount_loc }
    raise "#{mount_loc} not mounted" unless fields
    remount = shell_out('mount', '-o', "remount,#{fields[3]}", mount_loc)
    if remount.exitstatus == MOUNT_EX_FAIL
      true
    else
      remount.error!
      false
    end
  end

  # Check if provided filesystem type is netfs
  def netfs?(fstype)
    NET_FS_TYPES.include? fstype
  end
end
