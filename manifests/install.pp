# Class: ssh::install
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
class ssh::install {

  $client_pkg        = $ssh::client_pkg
  $client_pkg_ensure = $ssh::client_pkg_ensure
  $install_options   = $ssh::install_options
  $install_manage    = $ssh::install_manage
  $server_pkg        = $ssh::server_pkg
  $server_pkg_ensure = $ssh::server_pkg_ensure

  if $install_manage {
    package { 'ssh_client_pkg':
      ensure          => $client_pkg_ensure,
      name            => $client_pkg,
      install_options => $install_options,
    }

    package { 'ssh_server_pkg':
      ensure          => $server_pkg_ensure,
      name            => $server_pkg,
      install_options => $install_options,
    }
  }
  
}
