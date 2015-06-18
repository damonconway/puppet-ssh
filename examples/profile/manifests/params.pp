#
class profile::params {

  $ssh_admin_group   = ['root','ops']
  $ssh_bastion_group = ['sftp_clients']
  $ssh_groups        = hiera('ssh_groups', undef)
  $sshd_config_h     = hiera('sshd_config', {})
  
}
