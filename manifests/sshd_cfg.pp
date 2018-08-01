# Class: ssh::sshd_cfg
#
# Private class to create sshd_config, sshd_config_match, and
# sshd_config_subysystem resources from given hashes.
#
# Actions:
#   * Creates ssh_config* resources
#
class ssh::sshd_cfg {

  $config_manage         = $ssh::config_manage
  $defaults              = $ssh::defaults
  $sshd_config           = $ssh::sshd_config
  $sshd_config_match     = $ssh::sshd_config_match
  $sshd_config_subsystem = $ssh::sshd_config_subsystem

  file { '/etc/ssh/sshd_config':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  if $config_manage {
    if $sshd_config {
      $sshd_config.each |$cfg,$opts| {
        sshd_config { $cfg:
          * => $opts,
        }
      }
    }

    if $sshd_config_match {
      $sshd_config_match.each |$cfg,$opts| {
        sshd_config_match { $cfg:
          * => $opts,
        }
      }
    }

    if $sshd_config_subsystem {
      $sshd_config_subsystem.each |$cfg,$opts| {
        sshd_config_subsystem { $cfg:
          * => $opts,
        }
      }
    }
  }
  
}
