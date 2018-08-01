# Class: ssh::ssh_cfg
#
# Private class to create ssh_config resources.
#
# Actions:
#   * Creates ssh_config resources
#
class ssh::ssh_cfg {

  $config_manage    = $ssh::config_manage
  $ssh_config       = $ssh::ssh_config

  if $config_manage {
    if $ssh_config {
      $ssh_config.each |$cfg,$opts| {
        ssh_config { $cfg:
          * => $opts,
        }
      }
    }
  }
  
}
