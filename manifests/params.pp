# Class: ssh::params
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
class ssh::params {

  $config_manage     = true
  $client_pkg_ensure = 'present'
  $install_options   = undef
  $install_manage    = true
  $server_pkg_ensure = 'present'
  $service_ensure    = 'running'
  $service_maange    = true
  $ssh_config        = undef
  $ssh_config_match  = undef
  $sshd_config       = undef
  $sshd_config_match = undef

  case $::osfamily {
    'RedHat' : {
      $client_pkg   = 'openssh-clients'
      $server_pkg   = 'openssh-server'
      $service_name = 'sshd'
    }

    default : {
      fail("OS Family $::osfamily is not supported.")
    }
  }
  
  $defaults = {
    'notify' => Service['sshd_service'],
  }

}