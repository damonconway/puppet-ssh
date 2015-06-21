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

  $config_manage     = $ssh::config_manage
  $defaults          = $ssh::defaults
  $sshd_config       = $ssh::sshd_config
  $sshd_config_match = $ssh::sshd_config_match

  file { '/etc/ssh/sshd_config':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  if str2bool($config_manage) {
    if is_hash($sshd_config) {
      create_resources('sshd_config', $sshd_config)
    }

    if is_hash($sshd_config_match) {
      create_resources('sshd_config_match', $sshd_config_match)
    }
  }
  
}
