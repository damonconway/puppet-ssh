# Class: ssh::install
#
# Private class to make sure the ssh packages are installed.
#
# Actions:
#   * install client and server packages
#
class ssh::install {

  $client_pkg        = $ssh::client_pkg
  $client_pkg_ensure = $ssh::client_pkg_ensure
  $install_options   = $ssh::install_options
  $install_manage    = $ssh::install_manage
  $server_pkg        = $ssh::server_pkg
  $server_pkg_ensure = $ssh::server_pkg_ensure

  if $ssh::service_notify {
    $service_notify = Service['sshd_service']
  } else {
    $service_notify = undef
  }

  if $install_manage {
    package { 'ssh_client_pkg':
      ensure          => $client_pkg_ensure,
      name            => $client_pkg,
      install_options => $install_options,
      notify          => $service_notify,
    }

    package { 'ssh_server_pkg':
      ensure          => $server_pkg_ensure,
      name            => $server_pkg,
      install_options => $install_options,
      notify          => $service_notify,
    }
  }
  
}
