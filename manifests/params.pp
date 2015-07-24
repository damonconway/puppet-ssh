# Class: ssh::params
#
# This class contains defaults for the module.
#
# Parameters:
#   This class takes no parameters
#
# Actions:
#   Sets default values
#
# Requires:
#   None
#
# Sample Usage:
#   include ssh::params
#
#   class ssh inherits ssh::params { }
#
class ssh::params {

  $config_manage         = 'true'
  $client_pkg_ensure     = 'present'
  $install_options       = undef
  $install_manage        = 'true'
  $server_pkg_ensure     = 'present'
  $service_ensure        = 'running'
  $service_manage        = 'true'
  $ssh_config            = hiera('ssh_config', undef)
  $sshd_config           = hiera('sshd_config', undef)
  $sshd_config_match     = hiera('sshd_config_match', undef)
  $sshd_config_subsystem = hiera('sshd_config_subsystem', undef)

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
