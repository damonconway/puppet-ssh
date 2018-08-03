# Class: ssh::install
#
# Private class to make sure the ssh packages are installed.
#
# Actions:
#   * install client and server packages
#
class ssh::install {

  $moduli_gen_file = '/var/run/puppet/ssh_moduli_generated'

  if $ssh::service_notify {
    $service_notify = Service['sshd_service']
  } else {
    $service_notify = undef
  }

  package { 'ssh_client_pkg':
    ensure          => $ssh::client_pkg_ensure,
    name            => $ssh::client_pkg,
    install_options => $ssh::install_options,
    notify          => $service_notify,
  }

  package { 'ssh_server_pkg':
    ensure          => $ssh::server_pkg_ensure,
    name            => $ssh::server_pkg,
    install_options => $ssh::install_options,
    notify          => $service_notify,
  }

  # Commands from https://stribika.github.io/2015/01/04/secure-secure-shell.html
  if $ssh::moduli_type {
    $command = "ssh-keygen -G /etc/ssh/moduli.all -b 4096 && \
    ssh-keygen -T /etc/ssh/moduli.safe -f /etc/ssh/moduli.all && \
    mv /etc/ssh/moduli.safe /etc/ssh/moduli && \
    rm /etc/ssh/moduli.all && \
    touch ${moduli_gen_file}"

    exec { 'ssh::install - generate /etc/ssh/moduli':
      command => $command,
      creates => $moduli_gen_file,
      user    => 'root',
      require => Package['ssh_server_pkg'],
    }
  }

}
