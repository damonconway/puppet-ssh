# Class: ssh::service
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
class ssh::service {

  $service_ensure = $ssh::service_ensure
  $service_manage = $ssh::service_manage
  $service_name   = $ssh::service_name

  if str2bool($service_manage) {
    service { 'sshd_service':
      ensure    => $service_ensure,
      name      => $service_name,
      subscribe => File['/etc/ssh/sshd_config'],
    }
  }
  
}
