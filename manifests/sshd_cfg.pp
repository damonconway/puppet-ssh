# Class: ssh::sshd_cfg
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
class ssh::sshd_cfg {

  $config_manage  = $ssh::real_config_manage
  $defaults       = $ssh::defaults
  $sshd_cfg       = $ssh::sshd_cfg
  $sshd_cfg_match = $ssh::sshd_cfg_match


  if $config_manage {
    if $sshd_cfg {
      create_resources(ssh_config, $sshd_cfg, $defaults)
    }

    if $sshd_cfg_match {
      create_resources(ssh_config_match, $sshd_cfg_match, $defaults)
    }
  }
  
}
