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

  $config_manage    = $ssh::config_manage
  $ssh_config       = $ssh::ssh_config

  if str2bool($config_manage) {
    if is_hash($ssh_config) {
      create_resources('ssh_config', $ssh_config)
    }
  }
  
}
