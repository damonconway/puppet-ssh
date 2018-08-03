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

  case $facts['os']['family'] {
    'RedHat': {
      $client_pkg   = 'openssh-clients'
      $server_pkg   = 'openssh-server'
      $service_name = 'sshd'
    }

    'Debian': {
      $client_pkg   = 'openssh-client'
      $server_pkg   = 'openssh-server'
      $service_name = 'sshd'
    }

    default: {
      fail("OS Family ${facts['os']['family']} is not supported.")
    }
  }

}
