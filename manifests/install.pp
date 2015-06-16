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

  package { 'ssh_client_pkg':
    ensure          => $ssh::client_pkg_ensure,
    name            => $client_pkg,
    install_options => $ssh::install_options,
  }
  
  package { 'ssh_server_pkg':
    ensure          => $ssh::server_pkg_ensure,
    name            => $server_pkg,
    install_options => $ssh::install_options,
  }
  
}
