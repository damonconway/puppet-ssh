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

  $config_manage = $ssh::real_config_manage
  $ssh_cfg       = $ssh::ssh_cfg
  $ssh_cfg_match = $ssh::ssh_cfg_match

  if $config_manage {
    if $ssh_cfg {
      create_resources(ssh_config, $ssh_cfg)
    }

    if $ssh_cfg_match {
      create_resources(ssh_config_match, $ssh_cfg_match)
    }
  }
  
}
