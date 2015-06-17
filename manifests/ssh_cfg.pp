# Class: ssh::ssh_cfg
#
# This class does stuff that you describe here
#
# Parameters:
#   $parameter:
#       this global variable is used to do things
#
# Actions:
#   Actions should be described here
#
# Requires:
#   - Package["foopackage"]
#
# Sample Usage:
#
class ssh::ssh_cfg {

  $config_manage    = $ssh::real_config_manage
  $ssh_config       = $ssh::ssh_config
  $ssh_config_match = $ssh::ssh_config_match

  if $config_manage == true {
    if is_hash($ssh_config) {
      create_resources('ssh_config', $ssh_config)
    }

    if is_hash($ssh_config_match) {
      create_resources('ssh_config_match', $ssh_config_match)
    }
  }
  
}
