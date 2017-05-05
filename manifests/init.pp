# Class: ssh
#
# This class manages the ssh packages and service. By default, it does not make
# any configuration changes. Howeer, you can pass in 4 different hashes that
# will be processed with the resources provided by
# 'herculesteam/augeasproviders_ssh'. These resources are ssh_config,
# ssh_config_match, sshd_config, sshd_config_match, and each has a matching
# parameter you can give to pass to create_resources.
#
# Parameters:
#   $client_pkg:
#       Name of the client package to manage
#       Default: OS Dependent
#       Type: string
#
#   $client_pkg_ensure:
#       String to pass to ensure param on client package
#       Default: present
#       Type: string
#
#   $config_manage:
#       Determines if we should apply config changes
#       Default: true
#       Type: boolean
#
#   $install_options:
#       String to pass to install_options param on packages
#       Default: undef
#       Type: string
#
#   $server_pkg:
#       Name of the server package to manage
#       Default: OS Dependent
#       Type: string
#
#   $server_pkg_ensure:
#       String to pass to ensure param on server package
#       Default: present
#       Type: string
#
#   $service_ensure:
#       String to pass to ensure param on service
#       Default: running
#       Type: string
#
#   $service_manage:
#       Determines if we should manage the sshd service
#       Default: true
#       Type: boolean
#
#   $ssh_config:
#       Hash of options ot pass to ssh_config resources
#       Default: undef
#       Type: Hash
#
#   $sshd_config:
#       Hash of options ot pass to sshd_config resources
#       Default: undef
#       Type: Hash
#
#   $sshd_config_match:
#       Hash of options ot pass to sshd_config_match resources
#       Default: undef
#       Type: Hash
#
#   $sshd_config_subsystem:
#       Hash of options ot pass to ssh_config_subsystem resources
#       Default: undef
#       Type: Hash
#
# Actions:
#   Actions should be described here
#
# Requires:
#   - Package["foopackage"]
#
# Sample Usage:
#   Simply make sure the packages are installed and the service is running:
#     include ::ssh
#
class ssh (
  $client_pkg            = $ssh::params::client_pkg,
  $client_pkg_ensure     = $ssh::params::client_pkg_ensure,
  $config_manage         = $ssh::params::config_manage,
  $install_options       = $ssh::params::install_options,
  $install_manage        = $ssh::params::install_manage,
  $server_pkg            = $ssh::params::server_pkg,
  $server_pkg_ensure     = $ssh::params::server_pkg_ensure,
  $service_ensure        = $ssh::params::service_ensure,
  $service_manage        = $ssh::params::service_manage,
  $service_notify        = $ssh::params::service_notify,
  $ssh_config            = $ssh::params::ssh_config,
  $sshd_config           = $ssh::params::sshd_config,
  $sshd_config_match     = $ssh::params::sshd_config_match,
  $sshd_config_subsystem = $ssh::params::sshd_config_subsystem,
) inherits ssh::params {

  contain ssh::install
  contain ssh::service
  contain ssh::ssh_cfg
  contain ssh::sshd_cfg

  $service_name = $ssh::params::service_name

  if str2bool($service_notify) {
    $defaults = {}
  } else {
    $defaults = $ssh::params::defaults
  }

  Class['ssh::install'] ->
  Class['ssh::sshd_cfg'] ->
  Class['ssh::ssh_cfg'] ->
  Class['ssh::service']

}
