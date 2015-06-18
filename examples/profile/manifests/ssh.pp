# Example profile::ssh to configure /etc/sshd_config that will enforce certain
# settings for public facing hosts regardless of settings in hiera or the ENC. 
# It will also make sure that the admin groups are always in ssh no matter what.
#
# Additional ssh groups can be added by setting the ssh_groups variable in hiera.
#
# REQUIREMENTS:
#  * puppetlabs/stdlib
#  * puppetlabs/mysql
#
class profile::ssh inherits profile::params {

  $ssh_admin_group   = $profile::params::ssh_admin_group
  $ssh_bastion_group = $profile::params::ssh_bastion_group
  $ssh_groups        = $profile::params::ssh_groups
  $sshd_config_h     = $profile::params::sshd_config_h

  if is_array($ssh_groups) {
    $real_ssh_groups = concat($ssh_admin_group, $ssh_groups)
  } elsif is_string($ssh_groups) {
    $real_ssh_groups = concat($ssh_admin_group, [$ssh_groups])
  } else {
    $real_ssh_groups = $ssh_admin_group
  }

  $def_sshd_config = {
    'Protocol' => {
      'ensure' => 'present',
      'value'  => '2',
    },
    'PasswordAuthentication' => {
      'ensure' => 'present',
      'value'  => 'no',
    },
    'PermitRootLogin' => {
      'ensure' => 'present',
      'value'  => 'no',
    },
    'PubkeyAuthentication' => {
      'ensure' => 'present',
      'value'  => 'yes',
    },
    'RSAAuthentication' => {
      'ensure' => 'present',
      'value'  => 'yes',
    },
  }

  # Public sftp host for client uploads.
  $bastion_cfg = {
    'PasswordAuthentication' => {
      'ensure' => 'present',
      'value'  => 'yes',
    },
    'PermitRootLogin' => {
      'ensure' => 'present',
      'value'  => 'no',
    },
  }

  # Bastion host for internal users
  $sh_cfg = {
    'PermitRootLogin' => {
      'ensure' => 'present',
      'value'  => 'no',
    },
  }

  # Always enforce the bastion and sh configs
  $sshd_cfg = $::role ? {
    'bastion' => mysql_deepmerge($def_sshd_config, $sshd_config_h, $bastion_cfg, $allow_groups),
    'sh'      => mysql_deepmerge($def_sshd_config, $sshd_config_h, $sh_cfg, $allow_groups),
    default   => mysql_deepmerge($def_sshd_config, $sshd_config_h, $allow_groups),
  }

  class { '::ssh':
    sshd_config => $sshd_cfg,
  }

}
