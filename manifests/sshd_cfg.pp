# Class: ssh::sshd_cfg
#
# Private class to create sshd_config, sshd_config_match, and
# sshd_config_subysystem resources from given hashes.
#
# Actions:
#   * Creates ssh_config* resources
#
class ssh::sshd_cfg {

  $sshd_config = $ssh::merge_config ? {
    false   => $ssh::sshd_config,
    default => lookup('ssh::sshd_config',Optional[Hash],'deep',undef),
  }

  $sshd_config_match     = $ssh::merge_config ? {
    false   => $ssh::sshd_config_match,
    default => lookup('ssh::sshd_config_match',Optional[Hash],'deep',undef),
  }

  $sshd_config_subsystem = $ssh::merge_config ? {
    false => $ssh::sshd_config_subsystem,
    default => lookup('ssh::sshd_config_subsystem',Optional[Hash],'deep',undef),
  }

  $defaults = $ssh::service_notify ? {
    false   => {},
    default => { 'notify' => Service['sshd_service'], },
  }

  file { '/etc/ssh/sshd_config':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  if $ssh::config_manage {
    if $sshd_config {
      $sshd_config.each |$cfg,$opts| {
        sshd_config { $cfg:
          * => $opts + $defaults,
        }
      }
    }

    if $sshd_config_match {
      $sshd_config_match.each |$cfg,$opts| {
        sshd_config_match { $cfg:
          * => $opts + $defaults,
        }
      }
    }

    if $sshd_config_subsystem {
      $sshd_config_subsystem.each |$cfg,$opts| {
        sshd_config_subsystem { $cfg:
          * => $opts + $defaults,
        }
      }
    }
  }

}
