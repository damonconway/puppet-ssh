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

  $config_manage     = $ssh::real_config_manage
  $defaults          = $ssh::defaults
  $sshd_config       = $ssh::sshd_config
  $sshd_config_match = $ssh::sshd_config_match


  if $config_manage == true {
    if is_hash($sshd_config) {
      create_resources('sshd_config', $sshd_config, $defaults)
    }

    if is_hash($sshd_config_match) {
      create_resources('sshd_config_match', $sshd_config_match, $defaults)
    }
  }
  
}
