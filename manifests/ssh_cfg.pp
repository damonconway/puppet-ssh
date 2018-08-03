# Class: ssh::ssh_cfg
#
# Private class to create ssh_config resources.
#
# Actions:
#   * Creates ssh_config resources
#
class ssh::ssh_cfg {

  $ssh_config = $ssh::merge_config ? {
    false   => $ssh::ssh_config,
    default => lookup('ssh::ssh_config',Optional[Hash],'deep',undef),
  }

  if $ssh::config_manage {
    if $ssh_config {
      $ssh_config.each |$cfg,$opts| {
        ssh_config { $cfg:
          * => $opts,
        }
      }
    }
  }

}
